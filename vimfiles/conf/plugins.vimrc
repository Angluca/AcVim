"==============
"Plug
if !filereadable(expand("$VIM/autoload/plug.vim"))
	!curl -fLo $VIM/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
endif

let s:bundle_dir = expand("$VIM/bundle/")
call plug#begin(s:bundle_dir)

Plug 'vim-scripts/Align'
Plug 'vim-scripts/AutoComplPop'
"Plug 'vim-scripts/auto-pairs'
Plug 'vim-scripts/AutoClose--Alves'
Plug 'vim-scripts/DrawIt'
Plug 'vim-scripts/Mark--Karkat'
"Plug 'vim-scripts/bufexplorer.zip'
"Plug 'vim-scripts/colorv.vim'
Plug 'vim-scripts/vcscommand.vim'
"Plug 'vim-scripts/VimIM'
Plug 'vim-scripts/VisIncr'

"Plug 'angluca/nim.vim'
Plug 'zah/nim.vim'
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
"Plug 'Rip-Rip/clang_complete'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'

"Plug 'ycm-core/YouCompleteMe'

call plug#end()

if has("win32")
	"Not use Clang_complete in WIN
	let g:clang_complete_loaded = 1
endi
