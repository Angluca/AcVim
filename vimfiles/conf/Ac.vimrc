"=================================
" General
"=================================
"load plugins conf
so $VIMCONF/plugins.vimrc
nma<silent> \pp :call SwitchToBuf("$VIMCONF/plugins.vimrc")<cr>
"call pathogen#helptags()
execute pathogen#infect()
execute pathogen#infect('bundle_custom/{}')
"call pathogen#runtime_append_all_bundles()

" Ignore these filenames during enhanced command line completion.
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.a,*.dylib " compiled object files
set wildignore+=*.pyc " Python byte code
"set wildignore+=*.spl " compiled spelling word lists
"set wildignore+=*.sw? " Vim swap files
""""""""""""""""""""
"Functions
""""""""""""""""""""
fu! AcCreateMaps(target, combo)
if !hasmapto(a:target, 'n')
	exec 'nmap ' . a:combo . ' ' . a:target
endif
if !hasmapto(a:target, 'v')
	exec 'vmap ' . a:combo . ' ' . a:target
endif
endf

fu! AcCreateDir(dir_name)
	if finddir(a:dir_name) == ''
	silent call mkdir(a:dir_name)
	endif
endf

fu! AcClearUndo()
    echo "Do you wan clear all undo? [y]: "
    if getchar() != 121 "y
		echo "" | redraw
        return
    endif
	let ul_bak = &undolevels
	let md_bak = &modified
	let &undolevels=-1
	exe "normal a \<BS>\<Esc>"
	let &undolevels = ul_bak
	let &modified = md_bak
	unlet ul_bak md_bak
	redraw
	echo "Clear finish."
endf

fu! ToggleVisualEditMode()
if !exists('s:visualEditMode')
	let		s:visualEditMode = 1
	set		ve=all
	echo	'visual edit on'
else
	unlet	s:visualEditMode
	set		ve=
	echo	'visual edit off'
endif
endf

fu! ToggleQuickfix()
redir => ls_output
execute ':silent! ls'
redir END
let exists = match(ls_output, "Quickfix")
if exists == -1
	execute ':copen'
else
	execute ':cclose'
endif
endf

fu! QfMakeConv()
let qflist = getqflist()
for i in qflist
	let i.text = iconv(i.text, "cp936", "utf-8")
endfor
call setqflist(qflist)
endf

fu! SwitchToBuf(filename)
" find in current tab
let bufwinnr = bufwinnr(a:filename)
if bufwinnr != -1
	exec bufwinnr . "wincmd w"
	return
else
	" find in each tab
	tabfirst
	let tab = 1
	while tab <= tabpagenr("$")
		let bufwinnr = bufwinnr(a:filename)
		if bufwinnr != -1
			exec "normal " . tab . "gt"
			exec bufwinnr . "wincmd w"
			return
		endif
		tabnext
		let tab = tab + 1
	endwhile
	" not exist, new tab
	exec "e " . a:filename
endif
endf

fun! FileFormatOption()
if !exists("g:menutrans_fileformat_dialog")
	let g:menutrans_fileformat_dialog = "Select format for writing the file"
endif
if !exists("g:menutrans_fileformat_choices")
	let g:menutrans_fileformat_choices = "&Unix\n&Dos\n&Mac\n&Cancel"
endif
if &ff == "dos"
	let def = 2
elseif &ff == "mac"
	let def = 3
else
	let def = 1
endif
let n = confirm(g:menutrans_fileformat_dialog, g:menutrans_fileformat_choices, def, "Question")
if n == 1
	set ff=unix
elseif n == 2
	set ff=dos
elseif n == 3
	set ff=mac
endif
endfun

fu! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")
	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif
	if bufnr("%") == l:currentBufNum
		new
	endif
	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endf

func! DeleteTrailingWS()
exe "normal mz"
%s/\s\+$//ge
nohl
exe "normal `z"
endfunc
""""""""""""""""""""
"Create directory
""""""""""""""""""""
let data_dir = $HOME.'/vimdata/'
call AcCreateDir(data_dir)
call AcCreateDir(data_dir.'backup')
call AcCreateDir(data_dir.'swap')
call AcCreateDir(data_dir.'cache')
unlet data_dir
set backupdir=$HOME/vimdata/backup " where to put backup file
set directory=$HOME/vimdata/swap " where to put swap file

""""""""""""""""""""
"Base settings
""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible
"Sets how many lines of history VIM har to remember
set history=20
"utf-8 , ANSI, UNICODE
set encoding=utf-8
if has("win32")
set termencoding=utf-8
set fileencoding=utf-8
else
set termencoding=utf-8
set fileencoding=utf-8
endif

set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

"chinese=zh_CN.UTF-8 english=en_US.UTF-8
if v:lang == "zh_CN"
	set langmenu=zh_CN.UTF-8
	if has("gui_running")
		language messages zh_CN.utf-8
	else
		language messages en_US.UTF-8
	endif
"else
	"set langmenu=en_US.UTF-8
	"language messages en_US.UTF-8
endif

"Remove menu garbled
so $VIMRUNTIME/delmenu.vim
so $VIMRUNTIME/menu.vim

"Enable filetype plugin
"dont move it to top if you set unicode menu :)
filetype plugin indent on
"Set to auto read when a file is changed from the outside
set autoread
"Have the mouse enabled all the time:
set mouse=a

if	has("win32")
au QuickfixCmdPost make call QfMakeConv()
endif

"set path in current dir
if has("unix")
	if has("gui_running")
		"au	BufEnter	*	cd	%:h
		au	BufEnter	*	set	autochdir
	endif
endif

if has("mac")
	set guifont=Menlo:h14
endif

"Set mapleader
let g:mapleader = ","
"Fast editing of _vimrc
nmap <silent> \ee :call SwitchToBuf("$VIMCONF/Ac.vimrc")<cr>
"When _vimrc is edited, reload it
"au! bufwritepost Ac.vimrc so $VIMCONF/Ac.vimrc
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")

""""""""""""""""""""
"Colors and Fonts
""""""""""""""""""""
"Set font
"if has("unix")
"set gfn=Monospace\ 11
"endif
"Enable syntax hl
syntax enable
" color scheme
if has("gui_running")
	"start gvim maximized
	"if has("au")
	"au GUIEnter * simalt ~x
	"endif
	set guioptions-=T
	set guioptions-=m
	set guioptions-=L
	"set guioptions-=r
	"hi normal guibg=#294d4a
else
	set t_Co=256
endif " has
endif " exists(...)
colorscheme maroloccio
""""""""""""""""""""
"Fileformats
""""""""""""""""""""
"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"nmap ;$ :syntax sync fromstart<cr>
au BufEnter * :syntax sync fromstart
"Favorite filetypes
set ffs=unix,dos
"set ffs=unix
""""""""""""""""""""
"VIM userinterface
""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7
"set autochdir "auto set dir
"set tags=tags; "set dir tags
set tags=./tags,./../tags
au BufNewFile,BufRead *tags setlocal ft=tags
"set guifont=Consolas:h11
"Turn on WiLd menu
set wildmenu
"Always show current position
set ruler
"The commandbar is 2 high
set cmdheight=1
"Show line number
set nu
"Do not redraw, when running macros.. lazyredraw
set lz
"Change buffer - without saving
set hid
"Set backspace
set backspace=eol,start,indent
"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l
set whichwrap+=<,>
"Ignore case when searching
set ignorecase
set smartcase
"Include search
set incsearch
"Highlight search things
set hlsearch
"Set magic on
set magic
"No sound on errors.
au vimEnter * set vb t_vb=
set noerrorbells
set novisualbell
"show matching bracets
set showmatch
"How many tenths of a second to blink
"set mat=1

""""""""""""""""""""
"Statusline
""""""""""""""""""""
"Always hide the statusline
"set laststatus=2

"fu! CurDir()
"let curdir = buffer
"return curdir
"endf

"Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"Actually, the tab does not switch buffers, but my arrows
try
set switchbuf=useopen
set stal=1
catch
endtry

""""""""""""""""""""
"Buffer realted
""""""""""""""""""""
"Open a dummy buffer for paste
"nmap ;en :tabnew<cr>:setl buftype=nofile<cr>
"if has("unix")
"nmap ;et :tabnew ~/tmp/scratch.txt<cr>
"else
"nmap ;et :tabnew $TEMP/scratch.txt<cr>
"endif
set viminfo='10,\"30,!,:10,n~/vimdata/cache/_viminfo
"set viminfo='10,\"30,:10,%,nTemp/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"Don't close window, when deleting a buffer
com! Bclose call <SID>BufcloseCloseIt()
"Bclose function can be found in "Buffer related" section
nmap ;bd :Bclose<cr>

""""""""""""""""""""
"Session options
""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir
""""""""""""""""""""
"Files and backups
""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile
""""""""""""""""""""
"Folding
""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
	set fen
endif
if exists("&foldlevel")
	set fdl=0
endif
""""""""""""""""""""
"Text options
""""""""""""""""""""
set cindent shiftwidth=4 " Set cindent on to autoinent when editing C/C++ file, with 4 shift width
set softtabstop=4
set tabstop=4 " Set tabstop to 4 characters
"au FileType c,cpp,h,hpp,cc,cxx set expandtab
"set expandtab " Set expandtab on, the tab will be change to space automaticaly
""""""""""""""""""""
"Indent
""""""""""""""""""""
"Auto indent
set ai
"Smart indet
set si
"C-style indeting
set cindent
"Wrap lines
set wrap
""""""""""""""""""""
"cscope setting
""""""""""""""""""""
if has("cscope")
	"if has("win32")
		"set csprg=$VIMRUNTIME/cscope.exe
	"else
		"set csprg=/usr/bin/cscope
	"endif
	set csto=1
	set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

""""""""""""""""""""
"HTML related
""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1
"To HTML
let html_use_css = 1
let html_number_lines = 0
let use_xhtml = 1
au FileType html set ft=xml
au FileType html set syntax=html
""""""""""""""""""""
"Vim section
""""""""""""""""""""
"au FileType vim set nofen

""""""""""""""""""""
"Netrw
""""""""""""""""""""
let g:netrw_winsize = 30
let	g:netrw_home	=	$HOME.'/vimdata/cache'
"nmap <silent> ;Se :Sexplore!<cr>

""""""""""""""""""""
"User base options
""""""""""""""""""""
"My information
iab actime <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"edit vimrc enable fold
set fdm=marker
"au BufRead,BufNewFile Ac.vimrc setl fdm=marker fen

"window move
let g:wm_move_up = '<S-Up>'
let g:wm_move_right = '<S-Right>'
let g:wm_move_down = '<S-Down>'
let g:wm_move_left = '<S-Left>'
let g:wm_move_x = 20
let g:wm_move_y = 15

"Bash like
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-B> <Left>
cmap <C-F> <Right>

imap <C-A> <C-O>^
imap <C-E> <End>
imap <C-B> <Left>
imap <C-F> <Right>

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nmap <C-UP> <C-W>+
nmap <C-DOWN> <C-W>-
nmap <C-LEFT> <C-W><
nmap <C-RIGHT> <C-W>>

nmap j gj
nmap k gk
nmap ^ g^
nmap $ g$
"nmap 0 g0

"vn <C-S-X> "+x
"vn <C-S-C> "+y
"map <C-S-V>	"+gP
"vn <C-S-V> "+gP
"cmap <C-S-V> <C-R>+
"imap <C-S-V> <C-R>+

au FileType vim nmap <buffer> ;we :w!<cr>:source %<cr>

nmap <silent> ;wss :call DeleteTrailingWS()<cr>:w<cr>
nmap <silent> ;wsf :call DeleteTrailingWS()<cr>:w!<cr>

"complete
imap <s-space> <c-x><c-o>

"cut, copy & paste
"vmap <a-c> <c-insert>
"imap <a-v> <s-insert>
nmap ;yy "+Y
vmap ;yy "+y
nmap ;yx V"+x
vmap ;yx "+x
nmap ;pp "*gP
vmap ;pp "*gP
nmap <a-c> "+y
vmap <a-c> "+y
nmap <a-v> "*gP
vmap <a-v> "*gP
imap <a-v> "*gP
"file type
nmap ;ff :call FileFormatOption()<cr>
nmap ;fu :se fenc=utf-8<cr>
nmap ;fg :se fenc=GBK<cr>
"quickfix
nmap ;cl :call	ToggleQuickfix() <cr>
nmap ;cn :cn <cr>
nmap ;cp :cp <cr>
nmap ;co :cold <cr>
nmap ;ci :cnew <cr>
"visual edit mode
nmap ;ve :call	ToggleVisualEditMode() <cr>
"call AcCreateMaps('ToggleVisualEditMode', ';ve')
vmap ;ve :call	ToggleVisualEditMode() <cr>
"undo list
nmap ;ul :undol<cr>
nmap ;uc :call AcClearUndo() <cr>

"Fast saving
nmap <silent> ;ww :update<cr>
nmap <silent> ;wf :update!<cr>
"Fast quiting
nmap <silent> ;qw :wq<cr>
nmap <silent> ;qf :q!<cr>
nmap <silent> ;qq :q<cr>
nmap <silent> ;qa :qa<cr>
nmap <silent> ;<esc> :<esc>
"Fast remove highlight search
nmap <silent> ;<cr> :noh<cr>

nmap <silent> ;to :tabo<cr>
nmap <silent> ;tq :tabc<cr>
""Fast redraw
"nmap <silent> ;rr :redraw!<cr>
""Fast rewind
"nmap <silent> ;re :rewind<cr>

"generate tags
nmap \= :silent !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <cr>
""""""""""""""""""""
"User base filetypes
""""""""""""""""""""
au BufNewFile,BufRead README*,COPYING setlocal ft=txt
au BufNewFile,BufRead *.txt setl ft=txt
au BufNewFile,BufRead *.log setl ft=txt
au BufNewFile,BufRead *.asm setl ft=masm
au BufNewFile,BufRead *.inc setl ft=masm
au BufNewFile,BufRead *.asm setl mp=fasm\ %:p

au BufNewFile,BufRead *.mxml setl ft=mxml
au BufNewFile,BufRead *.as setl ft=actionscript
au BufNewFile,BufRead CMakeLists.txt setl ft=cmake
au BufNewFile,BufRead *.p setl ft=pawn
au BufNewFile,BufRead *.md,*.markdown setl ft=markdown
au BufNewFile,BufRead *.shd,*.sc setl ft=glsl

"objc
au BufNewFile,BufRead *.mm setl ft=objc
"squirrel script
au BufNewFile,BufRead *.nut setl ft=squirrel
au BufNewFile,BufRead *.nut setl mp=sq\ %:p
au BufNewFile,BufRead *.nut setl efm=%f:%l:%m

"godot script
au BufNewFile,BufRead *.gd setl ft=gdscript
"weixin
au BufNewFile,BufRead *.wxml setl ft=html
au BufNewFile,BufRead *.wxss setl ft=css

"if all file save will del trailing whitespace!!! like it
"au BufWrite *.* call DeleteTrailingWS()
" do not automaticlly remove trailing whitespace
"au BufWrite *.txt call DeleteTrailingWS()
au BufWrite *.nim,*.nims :call DeleteTrailingWS()
au BufWrite *.zig call DeleteTrailingWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :call DeleteTrailingWS()

"--------------------------------------------
""""""""""""""""""""
"AutoComplpop seting
""""""""""""""""""""
so $VIMCONF/autocomplete.vimrc
nmap <silent> \aa :call SwitchToBuf("$VIMCONF/autocomplete.vimrc")<cr>
"load user conf
so $VIMCONF/user.vimrc
nmap <silent> \uu :call SwitchToBuf("$VIMCONF/user.vimrc")<cr>
"--------------------------------------------
