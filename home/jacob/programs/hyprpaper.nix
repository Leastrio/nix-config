{inputs, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;
      preload = ["/home/jacob/Wallpapers/tropic_island_night.jpg"];
      wallpaper = [
        {
          monitor = "";
          path = "/home/jacob/Wallpapers/tropic_island_night.jpg";
        }
      ];
    };
  };
}
