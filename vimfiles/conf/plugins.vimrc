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
"Plug 'angluca/dither.vim'
"Plug 'angluca/axe.vim'
Plug 'angluca/ocen.vim'
"Plug 'angluca/nature.vim'
Plug 'angluca/nim.vim'
Plug 'ziglang/zig.vim'
Plug 'angluca/rust.vim'
"Plug 'angluca/quark.vim'
"Plug 'angluca/virgil.vim'
"Plug 'angluca/c2.vim'
"Plug 'angluca/zig.vim'
"Plug 'angluca/adept.vim'
"Plug 'angluca/hare.vim'
"Plug 'angluca/litac.vim'
"Plug 'elmcast/elm-vim'

Plug 'voldikss/vim-floaterm'
"Plug 'tmsvg/pear-tree' " auto-pair
Plug 'angluca/pairbc.vim' " auto-pair
"Plug 'Daiki48/pairbc.vim' " auto-pair
"Plug 'LunarWatcher/auto-pairs'
Plug 'girishji/scope.vim'
"Plug 'angluca/vimcomplete'
"Plug 'girishji/vimcomplete'
Plug 'girishji/vimsuggest'
"Plug 'girishji/ngram-complete.vim'
"Plug 'lifepillar/vim-mucomplete'

"Plug 'pusewicz/lsp'
Plug 'yegappan/lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'angluca/friendly-snippets'
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

Plug 'yianwillis/vimcdoc' " doc-zh
"Plug 'skywind3000/asyncrun.vim'
"Plug 'skywind3000/asynctasks.vim'
"Plug 'mattn/emmet-vim'
"Plug 'dkprice/vim-easygrep'
"Plug 'godlygeek/tabular'

"-----------------
call plug#end()
"==============

