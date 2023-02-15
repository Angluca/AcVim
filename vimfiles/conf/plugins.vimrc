"-------------------------------------------------------
if !filereadable(expand("$VIM/autoload/plug.vim"))
	!curl -fLo $VIM/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let s:bundle_dir = expand("$VIM/bundle/")
call plug#begin(s:bundle_dir)
"-------------------------------------------------------
" Plugin
"==================
"bundle_custom
"Plug 'eikenb/acp'
"==================
"bundle
"-----------------------
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'drmikehenry/vim-fixkey'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wuhulalala/ctrlp.vim'
Plug 'rhysd/clever-f.vim'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/AutoClose--Alves'
Plug 'vim-scripts/Mark--Karkat'

Plug 'junegunn/vim-easy-align'
Plug 'plasticboy/vim-markdown'
Plug 'jeetsukumaran/vim-buffersaurus'
Plug 'jeetsukumaran/vim-filesearch'

Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/linediff.vim'
Plug 'vim-scripts/VisIncr'
Plug 'zah/nim.vim'
Plug 'ziglang/zig.vim'

"Plug 'vim-scripts/VimIM'
"Plug 'garbas/vim-snipmate'
"Plug 'tikhomirov/vim-glsl'
"Plug 'Rip-Rip/clang_complete'
"Plug 'mattn/emmet-vim'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'dkprice/vim-easygrep'

"-----------------
call plug#end()
"==============

