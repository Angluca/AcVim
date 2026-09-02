vim9script
#=================================
# Option: \ee \aa \zz \vv \bb \ff
#=================================
g:mapleader = ","
so $VIMCONF/functions.vimrc
so $VIMCONF/plugins.vimrc
exe pathogen#infect()
exe pathogen#infect('bundle_local/{}')
#-------------------------------------
# Ignore these filenames during enhanced command line completion.
set wildignore+=*.luac  # Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.a,*.dylib  # compiled object files
set wildignore+=*.pyc  # Python byte code
set wildignore+=*.spl  # compiled spelling word lists
set wildignore+=*.sw?  # Vim swap files
# -- Create directory ------
g:AcMakeDir($VIMDATA)
g:AcMakeDir($VIMDATA .. 'backup')
g:AcMakeDir($VIMDATA .. 'swap')
g:AcMakeDir($VIMDATA .. 'cache')
set backupdir=$VIMDATA/backup  # where to put backup file
set directory=$VIMDATA/swap    # where to put swap file
#---------------------------
#load conf
so $VIMCONF/user.vimrc
so $VIMCONF/user2.vimrc
so $VIMCONF/autocomplete.vimrc

nmap \ee <Cmd>call g:SwitchToBuf($VIMCONF.."/ac.vimrc")<CR>
nmap \bb <Cmd>call g:SwitchToBuf($VIMCONF.."/plugins.vimrc")<CR>
nmap \aa <Cmd>call g:SwitchToBuf($VIMCONF.."/autocomplete.vimrc")<CR>
nmap \zz <Cmd>call g:SwitchToBuf($VIMCONF.."/user.vimrc")<CR>
nmap \vv <Cmd>call g:SwitchToBuf($VIMCONF.."/user2.vimrc")<CR>
nmap \ff <Cmd>call g:SwitchToBuf($VIMCONF.."/functions.vimrc")<CR>
# -- Base settings ------
# 错误提示只显示在行号上
set signcolumn=number
#Get out of VI's compatible mode..
set nocompatible
#Sets how many lines of history VIM has to remember
set history=20
#utf-8 , ANSI, UNICODE
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

#chinese=zh_CN.UTF-8, english=en_US.UTF-8
if v:lang == "zh_CN"
    set langmenu=zh_CN.UTF-8
    set helplang=cn
    if has("gui_running")
        language messages zh_CN.utf-8
    else
        language messages en_US.UTF-8
    endif
endif

#Remove menu garbled
so $VIMRUNTIME/delmenu.vim
so $VIMRUNTIME/menu.vim

#Enable filetype plugin
#dont move it to top if you set unicode menu :)
filetype plugin indent on
#Set to auto read when a file is changed from the outside
set autoread
#Have the mouse enabled all the time:
set mouse=a

if has("win32")
    au QuickfixCmdPost make call g:QfMakeConv()
endif

#set path in current dir
if has("unix")
    if has("gui_running")
        #au BufEnter * cd %:h
        au BufEnter * set autochdir
    endif
endif

if has("mac")
    if has("gui_running")
        set macmeta
    endif
    set guifont=Menlo:h15
endif

set scrolloff=7 # move auto scroll
# -- Colors and Fonts ------
# Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    ##Set font
    #if has("unix")
    #set gfn=Monospace\ 11
    #endif
    syntax enable
    #syntax sync
    #syntax sync minlines=500
    #syntax sync maxlines=25000
    #set synmaxcol=3000
    #set maxmempattern=2000
    ## color scheme
    if has("gui_running")
        ##start gvim maximized
        #if has("au")
            #au GUIEnter * simalt ~x
        #endif
        set guioptions-=T
        set guioptions-=m
        set guioptions-=L
        #set guioptions-=r
        #hi normal guibg=#294d4a
    else
        set t_Co=256
        #syntax sync
    endif  # has
endif
colorscheme maroloccio
# -- VIM interface ------
set ffs=unix,dos
au BufNewFile,BufRead *tags setl ft=tags
#Turn on WiLd menu
set wildmenu
#Always show current position
set ruler
#The commandbar is 2 high
set cmdheight=1
#Show line number
set nu
#Do not redraw, when running macros.. lazyredraw
set lz
#Change buffer - without saving
set hid
#Set backspace
set backspace=eol,start,indent
#Bbackspace and cursor keys wrap to
#set whichwrap+=<,>,h,l
set whichwrap+=<,>
#Ignore case when searching
#setlocal infercase "all same case
set ignorecase
set smartcase
#Include search
set incsearch
#Highlight search things
set hlsearch
#Set magic on
set magic
set noerrorbells
set novisualbell
#show matching bracets
set showmatch
#show all
#set conceallevel=0
#How many tenths of a second to blink
#set mat=1
#set shortmess+=c    " Shut off completion messages
set shortmess=aoOtTcCS
set ph=10  # complete popup window hight
#No sound on errors and clear jumplist.
au vimEnter * set vb t_vb=
au vimEnter * :clearjumps
#Always hide the statusline
#set laststatus=2
#Format the statusline
#set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
#Actually, the tab does not switch buffers, but my arrows
try
    set switchbuf=useopen
    set stal=1
catch
endtry
#Buffer realted
#set viminfo='10,"30,!,:10,n~/vimdata/cache/_viminfo
set viminfo='10,<10,s100,@0,f0,!,h,/10,:10,n$VIMDATA/cache/_viminfo
#au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exec "norm $"|endif|endif
#Session options
set sessionoptions-=curdir
set sessionoptions+=sesdir
#Files and backups
#Turn backup off
set nobackup
set nowb
#set noswapfile
#Enable folding, I find it very useful
if exists("&foldenable")
    set fen
endif
if exists("&foldlevel")
    set fdl=0
endif
#Text options
set cindent shiftwidth=4  # Set cindent on to autoinent when editing C/C++ file, with 4 shift width
set softtabstop=4
set tabstop=4  # Set tabstop to 4 characters
#au FileType c,cpp,h,hpp,cc,cxx set expandtab
set expandtab  # Set expandtab on, the tab will be change to space automaticaly
#Auto indent
set ai
#Smart indet
set si
#C-style indeting
set cindent
#Wrap lines
set wrap
#cscope setting
if has("cscope")
    set csto=1
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif
# HTML entities - used by xml edit plugin
g:xml_use_xhtml = 1
#g:xml_no_auto_nesting = 1
#To HTML
g:html_use_css = 1
g:html_number_lines = 0
g:use_xhtml = 1
au FileType html set ft=xml
au FileType html set syntax=html
#Netrw
g:netrw_winsize = 30
g:netrw_home = $VIMDATA .. 'cache'
g:netrw_nogx = 1
# -- User options ------
#Don't close window, when deleting a buffer
#Bclose function can be found in "Buffer related" section
nmap ;bd :Bclose<cr>
nmap ;bw :silent bw<cr>
nmap ;bW :silent bw!<cr>
#not use
map ZZ <esc>
map ZQ <esc>
map Q <esc>
map q <esc>
#tnoremapmap <m-q> :quit<cr>

#time
#iab xt <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
#edit vimrc enable fold
set fdm=marker

#window move
g:wm_move_up = '<m-s-Up>'
g:wm_move_down = '<m-s-Down>'
g:wm_move_left = '<m-s-Left>'
g:wm_move_right = '<m-s-Right>'
g:wm_move_x = 20
g:wm_move_y = 15

nmap <c-s-up> <C-W>+
nmap <c-s-down> <C-W>-
nmap <c-s-left> <C-W><
nmap <c-s-right> <C-W>>

#Bash like
map! <c-a> <home>
cmap <c-e> <end>
map! <c-f> <right>
map! <c-b> <left>

nmap <d-c> <c-c>
map! <d-c> <c-c>
map! <c-c> <RIGHT><ESC>
map! <m-c> <c-c>
map! <m-H> <Home>
map! <m-L> <End>
map! <m-h> <Left>
map! <m-l> <Right>
imap <m-j> <down>
imap <m-k> <up>
cmap <m-j> <c-n>
cmap <m-k> <c-p>
imap <m-;> ;
#map! Ó <Home>
#map! Ò <End>
#map! ˙ <Left>
#map! ¬ <Right>
#imap ∆ <down>
#imap ˚ <up>
#cmap ∆ <c-n>
#cmap ˚ <c-p>

#Smart way to move btw. windows
map <m-j> <C-W>j
map <m-k> <C-W>k
map <m-h> <C-W>h
map <m-l> <C-W>l
tmap <m-j> <C-W>j
tmap <m-k> <C-W>k
tmap <m-h> <C-W>h
tmap <m-l> <C-W>l
#map ∆ <C-W>j
#map ˚ <C-W>k
#map ˙ <C-W>h
#map ¬ <C-W>l
#tmap ∆ <C-W>j
#tmap ˚ <C-W>k
#tmap ˙ <C-W>h
#tmap ¬ <C-W>l

map <m-tab> <c-w>gt
map <m-s-tab> <c-w>gT
tmap <m-tab> <c-w>gt
tmap <m-s-tab> <c-w>gT

nmap j gj
nmap k gk
nmap ^ g^
nmap $ g$
xno < <gv
xno > >gv

#sel history
cmap <c-k> <up>
cmap <c-j> <down>

#au FileType vim nmap <buffer> ;we :w!<cr>:source %<cr>
nmap <silent> ;ds :call g:DelTWS(1)<cr>
#complete
#imap <s-space> <cr>

#cut, copy & paste
nmap <m-c> "+y
vmap <m-c> "+y
xmap <m-c> "+y
nmap <m-v> :setl paste<cr>"*gP
vmap <m-v> "*gP
imap <m-v> <c-r>+
xmap <m-v> <c-r>+
cmap <m-v> <c-r>+

#file format
nmap <Leader>ff :FmtOpt<cr>
nmap <Leader>fu :se fenc=utf-8<cr>
nmap <Leader>fg :se fenc=GBK<cr>
#quickfix
au Filetype qf set syntax=sh
set syntax=markdown.nim
#nmap <space>L  :cw<cr>
#nmap <space>l  :copen<cr>
#nmap <s-space>l  :copen<cr>
#nmap <s-space>J :cn<cr>
#nmap <s-space>K :cp<cr>
#nmap <s-space>O :cold<cr>
#nmap <s-space>I :cnew<cr>
nnoremap q :ccl<esc>
nnoremap Q q
nn q :FloatermHide<cr>:ccl<cr>
#nmap Q :ccl<esc>
#virtual edit mode
g:AcSetMap(':ToggleVE<cr>', ';vv')
#select find
vnoremap * y/<c-r>"<cr>
#undo list
nmap ;uc :call g:AcClsUndo()<cr>

#Fast saving
nmap ;ww :update<cr>
nmap ;wf :update!<cr>
#Fast quiting
nn <silent> ,q <esc>
nn <silent> ;q <esc>
nn <silent> ;qw :wq<cr>
nn <silent> ;qf :q!<cr>
nn <silent> ;qq :q<cr>
nn <silent> ;qa :qa<cr>
nn <silent> ;qf :FloatermKill!<cr>:q!<cr>
nn <silent> ;qa :FloatermKill!<cr>:qa<cr>
tnoremap <silent> <c-esc> <c-\><c-n>
#Fast remove highlight search
nmap <silent> ;<cr> :noh<cr>
nmap <silent> ;; ;<esc>
nmap <silent> ,, ,<esc>
nmap <space><space> \<space>
vno * y/<c-r>"<cr>
#fix terminal vi <c-v> bug
&t_BE = ""
&t_BD = "\e[?2004l"
#&t_TI = ""
#&t_TE = ""
set t_PS=\e[200~
set t_PE=\e[201~
if has("gui_running")
    nmap <d-d> :sp<cr>
    nmap <d-D> :vs<cr>
else
    nmap <m-d> :sp<cr>
    nmap <m-D> :vs<cr>
endif
map ge G
#-- cmd example: Template sh/build.sh
com! -nargs=+ Template :!cp $VIM/template/<args> %:p:h

defcompile
