{
  lib,
  pkgs,
  ...
}: let
  ladspa = "${pkgs.ladspaPlugins}/lib/ladspa";
in {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."99-mic-filter" = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Scarlett Mic (Filtered)";
            "media.name" = "Scarlett Mic (Filtered)";
            "filter.graph" = {
              nodes = [
                # Cut rumble, desk bumps and fan hum below the voice.
                {
                  type = "builtin";
                  name = "highpass";
                  label = "bq_highpass";
                  control = {
                    "Freq" = 80.0;
                    "Q" = 0.707;
                  };
                }
                # AI noise suppression. Raise the threshold if noise leaks
                {
                  type = "ladspa";
                  name = "rnnoise";
                  plugin = "${pkgs.rnnoise-plugin.ladspa}/lib/ladspa/librnnoise_ladspa.so";
                  label = "noise_suppressor_mono";
                  control = {
                    "VAD Threshold (%)" = 30.0;
                    "VAD Grace Period (ms)" = 400.0;
                    "Retroactive VAD Grace (ms)" = 0.0;
                  };
                }
                # Gentle compression to even out loud vs quiet speech.
                {
                  type = "ladspa";
                  name = "compressor";
                  plugin = "${ladspa}/sc4m_1916.so";
                  label = "sc4m";
                  control = {
                    "RMS/peak" = 0.0;
                    "Attack time (ms)" = 10.0;
                    "Release time (ms)" = 150.0;
                    "Threshold level (dB)" = -20.0;
                    "Ratio (1:n)" = 3.0;
                    "Knee radius (dB)" = 6.0;
                    "Makeup gain (dB)" = 6.0;
                  };
                }
                # Safety net so shouting/laughing never clips.
                {
                  type = "ladspa";
                  name = "limiter";
                  plugin = "${ladspa}/fast_lookahead_limiter_1913.so";
                  label = "fastLookaheadLimiter";
                  control = {
                    "Input gain (dB)" = 0.0;
                    "Limit (dB)" = -1.0;
                    "Release time (s)" = 0.05;
                  };
                }
              ];
              links = [
                {
                  output = "highpass:Out";
                  input = "rnnoise:Input";
                }
                {
                  output = "rnnoise:Output";
                  input = "compressor:Input";
                }
                {
                  output = "compressor:Output";
                  input = "limiter:Input 1";
                }
              ];
              inputs = ["highpass:In"];
              outputs = ["limiter:Output 1"];
            };
            "capture.props" =
              {
                "node.name" = "capture.mic_filter";
                "node.passive" = true;
                "audio.rate" = 48000;
                "audio.channels" = 1;
                "audio.position" = ["MONO"];
                "target.object" = "alsa_input.usb-Focusrite_Scarlett_Solo_USB_Y7PM6NJ9B82343-00.HiFi__Mic1__source";
              };
            "playback.props" = {
              "node.name" = "mic_filter_source";
              "media.class" = "Audio/Source";
              "audio.rate" = 48000;
              "audio.channels" = 1;
              "audio.position" = ["MONO"];
            };
          };
        }
      ];
    };
  };
}
