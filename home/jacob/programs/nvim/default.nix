{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    withRuby = false;
    withPython3 = false;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      nixd
      alejandra
    ];

    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      catppuccin-nvim
      which-key-nvim
      flash-nvim
      bufferline-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-treesitter.withAllGrammars
      nvim-autopairs
      nvim-lspconfig
      rainbow-delimiters-nvim
      nvim-web-devicons
      nvim-tree-lua
      blink-cmp
      conform-nvim
      mini-surround
      mini-ai
      fidget-nvim
      todo-comments-nvim
      indent-blankline-nvim

      # Required for telescope
      plenary-nvim
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
