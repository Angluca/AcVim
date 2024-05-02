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
Plug 'angluca/zig.vim'
Plug 'angluca/nim.vim'
Plug 'angluca/ocen.vim'
Plug 'angluca/adept.vim'
"Plug 'angluca/hare.vim'
"Plug 'angluca/litac.vim'
"Plug 'angluca/virgil.vim'

"Plug 'vim-jp/vim-cpp'
"Plug 'angluca/scope.vim'
Plug 'girishji/scope.vim'
Plug 'girishji/vimcomplete'
Plug 'girishji/autosuggest.vim'
Plug 'girishji/ngram-complete.vim'
"Plug 'girishji/vsnip-complete.vim'
"Plug 'LunarWatcher/auto-pairs'

Plug 'yegappan/lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'haya14busa/is.vim'
Plug 'rust-lang/rust.vim'

"Plug 'Jorengarenar/miniSnip'
"Plug 'haya14busa/incsearch.vim'
"Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'drmikehenry/vim-fixkey'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'rhysd/clever-f.vim'
Plug 'preservim/tagbar'
"Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
"Plug 'Angluca/auto-pairs'
"Plug 'Eliot00/auto-pairs' "v9s
"Plug 'vim-scripts/Mark--Karkat'

"Plug 'preservim/vim-markdown'
"Plug 'tpope/vim-markdown'
Plug 'jeetsukumaran/vim-buffersaurus'
"Plug 'jlanzarotta/bufexplorer'

"Plug 'scrooloose/syntastic'
Plug 'vim-scripts/VisIncr'
"Plug 'tpope/vim-fugitive'
"Plug 'AndrewRadev/linediff.vim'
"Plug 'ziglang/zig.vim'
"Plug 'elmcast/elm-vim'
"Plug 'maralla/completor.vim'
"Plug 'lifepillar/vim-mucomplete'
"Plug 'sheerun/vim-polyglot'

Plug 'skywind3000/asyncrun.vim'
"Plug 'hahdookin/miniterm.vim'
"Plug 'skywind3000/asynctasks.vim'
"Plug 'skywind3000/vim-quickui.vim'
"Plug 'jayli/vim-easycomplete'
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
"Plug 'SirVer/ultisnips'

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'

"-----------------
call plug#end()
"==============

