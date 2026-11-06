{pkgs, ...}: let
  lemna = "$HOME/Projects/lemna";
in {
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/bin/sh

      mkdir -p "$HOME/.local/state/river"

      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river

      ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &
      ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &

      cd "${lemna}" || exit 1
      while true; do
        MIX_ENV=prod nix develop --command \
          elixir --sname lemna -S mix run --no-halt \
          >> "$HOME/.local/state/river/wm.log" 2>&1
        sleep 1
      done
    '';
  };
}
