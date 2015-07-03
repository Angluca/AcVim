"if !isdirectory(expand("$VIM/bundle/neobundle.vim"))
	"!git clone https://github.com/Shougo/neobundle.vim $VIM/bundle/neobundle.vim
"endif

"if has('vim_starting')
	"set nocompatible               " Be iMproved
   "" Required:
	"set rtp+=$VIM/bundle/neobundle.vim
"endif

"let g:neobundle#types#git#default_protocol = 'https'
"call neobundle#rc(expand('$VIM/bundle', 1))
"NeoBundleFetch 'Shougo/neobundle.vim'
"call neobundle#end()
"filetype plugin indent on

"set wildignore+=doc
"set wildignore+=.git
"set wildignore+=.git/*
"set wildignore+=*/.git/*

"NeoBundleCheck


"==============
"vundle option

"if !isdirectory(expand("$VIM/bundle/Vundle.vim/.git"))
	"!git clone https://github.com/gmarik/Vundle.vim.git $VIM/bundle/Vundle.vim
"endif

"set nocompatible
"filetype off
"set rtp+=$VIM/bundle/Vundle.vim

"call vundle#rc()
"Plugin 'tpope/vim-markdown'

"call vundle#end()
"filetype plugin indent on

"==============
"Plug
if !filereadable(expand("$VIM/autoload/plug.vim"))
	!curl -fLo $VIM/autoload/plug.vim  https://raw.github.com/junegunn/vim-plug/master/plug.vim
endif

let s:bundle_dir = expand("$VIM/bundle")
call plug#begin(s:bundle_dir)

Plug 'Align'
Plug 'AutoComplPop'
"Plug 'auto-pairs'
Plug 'AutoClose--Alves'
Plug 'DrawIt'
Plug 'Mark--Karkat'
"Plug 'bufexplorer.zip'
"Plug 'colorv.vim'
Plug 'vcscommand.vim'
"Plug 'VimIM'
Plug 'VisIncr'

Plug 'angluca/nim.vim'
Plug 'jlanzarotta/bufexplorer'
"Plug 'Shougo/unite.vim'
"Plug 'quabug/vim-gdscript'
Plug 'tikhomirov/vim-glsl'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jeetsukumaran/vim-buffersaurus'
"Plug 'jiangmiao/auto-pairs'
"Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'drmikehenry/vim-fixkey'
Plug 'jeetsukumaran/vim-filesearch'
Plug 'easymotion/vim-easymotion'
Plug 'dkprice/vim-easygrep'
Plug 'junegunn/vim-easy-align'
Plug 'jmcantrell/vim-diffchanges'

Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'AndrewRadev/linediff.vim'
Plug 'sjl/gundo.vim'
Plug 'motemen/git-vim'
Plug 'mattn/emmet-vim'
Plug 'kien/ctrlp.vim'
Plug 'Rip-Rip/clang_complete'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

call plug#end()

