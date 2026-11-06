{pkgs, ...}: let
  wm = "$HOME/.local/bin/river-wm";
in {
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/bin/sh

      ${pkgs.wlr-randr}/bin/wlr-randr \
        --output DP-1 --mode 2560x1440@170Hz --pos 0,520 \
        --output HDMI-A-1 --mode 2560x1440@59Hz --pos 2560,0 --transform 270 \
        --output DP-2 --mode 2560x1600@120Hz --pos 480,1960 --scale 1.6

      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river

      ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &
      ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &

      noctalia &

      mkdir -p "$HOME/.local/state/river"
      while true; do
        if [ -x "${wm}" ]; then
          "${wm}" >> "$HOME/.local/state/river/wm.log" 2>&1
        else
          echo "$(date): ${wm} not found" >> "$HOME/.local/state/river/wm.log"
        fi
        sleep 1
      done
    '';
  };
}