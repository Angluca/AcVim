"-------------------------------------------------------
if !filereadable(expand("$VIM/autoload/plug.vim")) "{{{
	!curl -fLo $VIM/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let s:bundle_dir = expand("$VIM/bundle/")
call plug#begin(s:bundle_dir)
"}}}
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
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wuhulalala/ctrlp.vim'
"Plug 'rhysd/clever-f.vim'
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
"Plug 'Eliot00/auto-pairs' "v9s
"Plug 'vim-scripts/Mark--Karkat'

Plug 'preservim/vim-markdown'
Plug 'jeetsukumaran/vim-buffersaurus'
"Plug 'jeetsukumaran/vim-filesearch'

Plug 'scrooloose/syntastic'
Plug 'vim-scripts/VisIncr'
"Plug 'tpope/vim-fugitive'
"Plug 'AndrewRadev/linediff.vim'
"Plug 'zah/nim.vim'
"Plug 'ziglang/zig.vim'
"Plug 'elmcast/elm-vim'
"Plug 'skywind3000/vim-quickui'
"Plug 'SirVer/ultisnips'
"Plug 'maralla/completor.vim'
"Plug 'lifepillar/vim-mucomplete'
"Plug 'sheerun/vim-polyglot'

Plug 'jayli/vim-easycomplete'
"Plug 'SirVer/ultisnips'
"Plug 'mattn/emmet-vim'
"Plug 'vim-scripts/VimIM'
"Plug 'tikhomirov/vim-glsl'
"Plug 'Rip-Rip/clang_complete'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'tenfyzhong/CompleteParameter.vim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'dkprice/vim-easygrep'
"Plug 'godlygeek/tabular'
"Plug 'preservim/vimux'

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'

"-----------------
call plug#end()
"==============

