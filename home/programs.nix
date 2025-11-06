{ primaryUser, pkgs, config, ... }:
{
  programs = {
    vim = {
	    enable = true;
	    plugins = with pkgs.vimPlugins; [
                vim-surround
                vim-unimpaired
                vim-nix
                vim-gitgutter
                vim-tmux-focus-events
	    ];
            # Set this so that it doesn't install the 'vim-sensible' plugin
            packageConfigurable = pkgs.vim;
            extraConfig = ''
	      set number
	      set mouse=a
	      set autoindent
	      set smartindent
	      set smartcase
	      set ignorecase " So that smartcase works
	      set hlsearch
	      set incsearch
              " this clipboardy thing doesn't really work :(
              " set clipboard=unnamedplus
	      syntax on
	      filetype plugin indent on
	      set showmatch
	      set matchtime=2
	      set noerrorbells
	      set noswapfile

              " Puts the file position into the command line at the bottom
              " set ruler

              " Remove the annoying status bar at the bottom.
              " More info about it: :help status-line
              set laststatus=0
              " https://unix.stackexchange.com/a/684672
              autocmd BufRead,BufNewFile * set laststatus=0

              " lets me use vim-surround with capital too
	      vmap s S

              " Keep visual selection highlighted on move
              vnoremap < <gv
              vnoremap > >gv
              '';
    };
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        # tmux-sensible I should really investigate this
        resurrect
        continuum
      ];
      extraConfig = builtins.readFile ./tmux.conf;
    };

    # https://github.com/lovesegfault/nix-config/blob/master/users/bemeurer/dev/default.nix#L24
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings.user = {
	      email = "gareth.seddon@gmail.com";
	      name = "Gareth Seddon";
      };
      lfs = {
        enable = true;
        skipSmudge = true;
      };
      ignores = [
      ".idea"
      "*.code-workspace"
      ".vscode"
      "**/.DS_Store"
      ];
      settings = {
        alias = {
          st = "status";
          co = "checkout";
          br = "branch";
          ci = "commit";
          push-new-branch = "push -u origin HEAD";
          root = "rev-parse --show-toplevel";
          dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)%an <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
        };
        core = {
	  attributesfile = "${config.home.homeDirectory}/.gitattributes";
        };
        color.ui = "auto";
        push.default = "simple";
      };
    };
  };
}
