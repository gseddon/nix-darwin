{ pkgs, ... }:
{
  programs.vim = {
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
        set clipboard=unnamed
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
}