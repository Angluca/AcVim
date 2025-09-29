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
Plug 'yianwillis/vimcdoc' " doc-zh
Plug 'angluca/zig.vim'
Plug 'angluca/nim.vim'
Plug 'angluca/ocen.vim'
Plug 'c2lang/c2.vim'
"Plug 'angluca/adept.vim'
"Plug 'angluca/rust.vim'
"Plug 'angluca/hare.vim'
"Plug 'angluca/litac.vim'
"Plug 'angluca/virgil.vim'
"Plug 'ziglang/zig.vim'
"Plug 'elmcast/elm-vim'

Plug 'tmsvg/pear-tree' " auto-pair
"Plug 'LunarWatcher/auto-pairs'
"Plug 'angluca/scope.vim'
Plug 'girishji/scope.vim'
Plug 'girishji/vimcomplete'
Plug 'girishji/vimsuggest'
"Plug 'girishji/ngram-complete.vim'

Plug 'pusewicz/lsp'
"Plug 'yegappan/lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'angluca/friendly-snippets'
"Plug 'rafamadriz/friendly-snippets'
Plug 'haya14busa/is.vim'

Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'drmikehenry/vim-fixkey'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'rhysd/clever-f.vim'
Plug 'preservim/tagbar'
Plug 'junegunn/vim-easy-align'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'easymotion/vim-easymotion'

Plug 'jeetsukumaran/vim-buffersaurus'
"Plug 'preservim/vim-markdown'
"Plug 'tpope/vim-markdown'
"Plug 'jlanzarotta/bufexplorer'

Plug 'vim-scripts/VisIncr'
"Plug 'scrooloose/syntastic'
"Plug 'tpope/vim-fugitive'
"Plug 'AndrewRadev/linediff.vim'

Plug 'skywind3000/asyncrun.vim'
"Plug 'skywind3000/vim-quickui'
"Plug 'skywind3000/asynctasks.vim'
"Plug 'hahdookin/miniterm.vim'
"Plug 'mattn/emmet-vim'
"Plug 'dkprice/vim-easygrep'
"Plug 'godlygeek/tabular'

"-----------------
call plug#end()
"==============

