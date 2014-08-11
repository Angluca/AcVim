if !isdirectory(expand("$VIM/bundle/neobundle.vim"))
	!git clone https://github.com/Shougo/neobundle.vim $VIM/bundle/neobundle.vim
endif

if has('vim_starting')
	set nocompatible               " Be iMproved
   " Required:
	set rtp+=$VIM/bundle/neobundle.vim
endif

let g:neobundle#types#git#default_protocol = 'https'
call neobundle#rc(expand('$VIM/bundle', 1))

NeoBundle 'Align'
NeoBundle 'AutoComplPop'
NeoBundle 'Buffersaurus'
NeoBundle 'DrawIt'
NeoBundle 'Mark--Karkat'
NeoBundle 'bufexplorer.zip'
NeoBundle 'colorv.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'VimIM'
NeoBundle 'VisIncr'


NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'drmikehenry/vim-fixkey'
NeoBundle 'jeetsukumaran/vim-filesearch'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'dkprice/vim-easygrep'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'jmcantrell/vim-diffchanges'
NeoBundle 'bling/vim-airline'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'motemen/git-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'

NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
filetype plugin indent on

set wildignore+=doc
set wildignore+=.git
set wildignore+=.git/*
set wildignore+=*/.git/*

NeoBundleCheck


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

