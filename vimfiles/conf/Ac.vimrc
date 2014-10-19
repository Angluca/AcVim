"
" Last Change: 23/11/13 23:57:50
"---------------------------------
"=================================
" General 
"=================================
"load plugins conf
source $VIMCONF/plugins.vimrc
nma<silent> \pp :call SwitchToBuf("$VIMCONF/plugins.vimrc")<cr>
"call pathogen#helptags()
call pathogen#infect()
call pathogen#infect("bundle_custom")
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
function! s:CreateMaps(target, combo)
if !hasmapto(a:target, 'n')
	exec 'nmap ' . a:combo . ' ' . a:target
endif
if !hasmapto(a:target, 'v')
	exec 'vmap ' . a:combo . ' ' . a:target
endif
endfunction

function! s:CreateDir(dir_name)
	if finddir(a:dir_name) == ''
	silent call mkdir(a:dir_name)
	endif
endfunction

function! ToggleVisualEditMode()
if !exists('s:visualEditMode')
	let		s:visualEditMode = 1
	set		ve=all
	echo	'visual edit on'
else
	unlet	s:visualEditMode
	set		ve=
	echo	'visual edit off'
endif
endfunction

function! ToggleQuickfix()
redir => ls_output
execute ':silent! ls'
redir END
let exists = match(ls_output, "Quickfix")
if exists == -1
	execute ':copen'
else
	execute ':cclose'
endif
endfunction

function! QfMakeConv()
let qflist = getqflist()
for i in qflist
	let i.text = iconv(i.text, "cp936", "utf-8")
endfor
call setqflist(qflist)
endfunction

function! SwitchToBuf(filename)
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
endfunction

fun! s:FileFormat()
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

function! <SID>BufcloseCloseIt()
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
endfunction

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
call s:CreateDir(data_dir)
call s:CreateDir(data_dir.'backup')
call s:CreateDir(data_dir.'swap')
call s:CreateDir(data_dir.'cache')
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
" Chinese
"utf-8 , ANSI, UNICODE
set encoding=utf-8
"set langmenu=zh_CN.UTF-8
set langmenu=zh_CN.UTF-8
"chinese=zh_CN.UTF-8 english=en_US.UTF-8
"language message en_US.UTF-8
if has("gui_running")
	language messages zh_CN.utf-8
else
	language messages en_US.UTF-8
endif

if has("win32")
set termencoding=utf-8
set fileencoding=utf-8
else
set termencoding=utf-8
set fileencoding=utf-8
endif

set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

"Enable filetype plugin
"dont move it to top if you set unicode menu :)
filetype plugin indent on
"Set to auto read when a file is changed from the outside
set autoread
"Have the mouse enabled all the time:
set mouse=a
"Set mapleader
let g:mapleader = ","

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

"cut, copy & paste
if has("mac")
	vmap "+y :w !pbcopy<CR><CR>
	nmap "+p :r !pbpaste<CR><CR>
	nmap "+gP :r !pbpaste<CR><CR>
	vmap "*y :w !pbcopy<CR><CR>
	nmap "*p :r !pbpaste<CR><CR>
	nmap "*gP :r !pbpaste<CR><CR>
	set guifont=Menlo:h14
endif

"Fast editing of _vimrc
nmap <silent> \ee :call SwitchToBuf("$VIMCONF/Ac.vimrc")<cr>
"When _vimrc is edited, reload it
"autocmd! bufwritepost Ac.vimrc source $VIMCONF/Ac.vimrc
""""""""""""""""""""
"Colors and Fonts
""""""""""""""""""""
"Set font
"if has("unix")
"set gfn=Monospace\ 11
"endif
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
"Enable syntax hl
syntax enable
" color scheme
if has("gui_running")
	"start gvim maximized
	"if has("autocmd")
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
autocmd BufEnter * :syntax sync fromstart
"Favorite filetypes
set ffs=unix,dos
"set ffs=unix
""""""""""""""""""""
"VIM userinterface
""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7
set tags=./tags,./../tags
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

"function! CurDir()
"let curdir = buffer
"return curdir
"endfunction

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
"set softtabstop=2
set tabstop=4 " Set tabstop to 4 characters
"autocmd FileType c,cpp,h,hpp,cc,cxx set expandtab
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
"autocmd FileType vim set nofen
"=================================
" Plugin configuration 
"=================================
""""""""""""""""""""
"Ctrlp setting
""""""""""""""""""""
let g:ctrlp_cache_dir = $HOME.'/vimdata/ctrlp'
let g:ctrlp_map = ';cf'
"nmap <silent> ;cf :CtrlP<cr>
nmap <silent> ;cb :CtrlPBuffer<cr>
nmap <silent> ;cm :CtrlPMRUFiles<cr>
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll|zip|rar|tags|tar)$',
			\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
			\ }
""""""""""""""""""""
"BufExplorer setting
""""""""""""""""""""
let g:bufExplorerDefaultHelp=0 " Do not show default help.
let g:bufExplorerShowRelativePath=1 " Show relative paths.
let g:bufExplorerSortBy='mru' " Sort by most recently used.
let g:bufExplorerSplitRight=0 " Split left.
let g:bufExplorerSplitVertical=1 " Split vertically.
"let g:bufExplorerSplitVertSize = 30 " Split width
let g:bufExplorerUseCurrentWindow=1 " Open in new window.
"let g:bufExplorerMaxHeight=50 " Max height

""""""""""""""""""""
"Taglist
""""""""""""""""""""
"if has("win32")
	"let Tlist_Ctags_Cmd = 'ctags'
"elseif has("unix")
	"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"endif
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Open = 0
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
let Tlist_BackToEditBuffer = 0 " If no close on select, let the user choose back to edit buffer or not
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 20
let Tlist_Compact_Format = 1 " do not show help
"let tlist_hlsl_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;v:variable;f:function'

nmap <silent> ;tL :Tlist<cr>

""""""""""""""""""""
"Tagbar (similar taglist)
""""""""""""""""""""
"let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autoclose = 1
let g:tagbar_width = 28
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
"let g:tagbar_sort = 0
"let g:tagbar_expand = 1
"let g:tagbar_singleclick = 1
"let g:tagbar_foldlevel = 2
"let g:tagbar_systemenc = 'cp936'
"let g:tagbar_updateonsave_maxlines = 10000
nmap <silent> ;tl :TagbarToggle<cr>
""""""""""""""""""""
"Netrw
""""""""""""""""""""
let g:netrw_winsize = 30
let	g:netrw_home	=	$HOME.'/vimdata/cache'
"nmap <silent> ;fe :Sexplore!<cr>

""""""""""""""""""""
"Omnicppcompl setting
""""""""""""""""""""
if has("win32")
	"autocmd FileType c,cpp set tags +=$VIMDICT/winxtags
endif
autocmd FileType c,cpp set tags +=$VIMDICT/cpptags

" set completeopt as don't show menu and preview
set completeopt=menuone
" use global scope search
let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 1
" 0 = auto
" 1 = always show all members
"let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1
" This option can be use if you don't want to parse using namespace declarations in included files and want to add namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std","_GLIBCXX_STD"]
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
""""""""""""""""""""
"Neocomplete
""""""""""""""""""""
"source $VIMCONF/vneocomplete.conf
"nmap <silent> \nn :call SwitchToBuf("$VIMCONF/neocomplete.vimrc")<cr>
""""""""""""""""""""
"AutoComplpop seting
""""""""""""""""""""
source $VIMCONF/autocomplete.vimrc
nmap <silent> \aa :call SwitchToBuf("$VIMCONF/autocomplete.vimrc")<cr>
""""""""""""""""""""
"NERDTree seting
""""""""""""""""""""
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0
let NERDTreeWinPos='left'
let NERDTreeWinSize=20
let NERDTreeIgnore=['\.o$', '\~$','\.a$','\.bak$','\.d$','\.ncb$','\.bmp$','\.exe$','\.tar\.gz$','\.7z$','\.zip$','\.rar$','\.swp$','\.dll$','\.obj$']
nmap <silent> ;tt :NERDTreeToggle <cr>

""""""""""""""""""""
"Sketch seting
""""""""""""""""""""
nmap <F1> :call ToggleSketch()<CR>

""""""""""""""""""""
"ShowMarks seting
""""""""""""""""""""
let showmarks_include = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_ignore_type="hmpq"    "help,non-modify,preview,quick-fix buffer do not display
"nmap <silent> <leader>mt <Plug>ShowMarksToggle
""nmap <silent> <leader>mo <Plug>ShowmarksShowMarksOn
"nmap <silent> <leader>mc <Plug>ShowmarksClearMark
"nmap <silent> <leader>ma <Plug>ShowmarksClearAll
"nmap <silent> <leader>mm <Plug>ShowmarksPlaceMark
""""""""""""""""""""
"Marks seting
""""""""""""""""""""
nmap <unique> <silent> ;mm <Plug>MarkSet
vmap <unique> <silent> ;mm <Plug>MarkSet
nmap <unique> <silent> ;/ <Plug>MarkRegex
vmap <unique> <silent> ;/ <Plug>MarkRegex
nmap <unique> <silent> ;mc <Plug>MarkClear
nmap <unique> <silent> ;ma <Plug>MarkAllClear
nmap <unique> <silent> ;mt <Plug>MarkToggle

nmap <unique> <silent> ;n <Plug>MarkSearchCurrentNext
nmap <unique> <silent> ;N <Plug>MarkSearchCurrentPrev
nmap <unique> <silent> ;* <Plug>MarkSearchAnyNext
nmap <unique> <silent> ;# <Plug>MarkSearchAnyPrev
nmap <unique> <silent> * <Plug>MarkSearchNext
nmap <unique> <silent> # <Plug>MarkSearchPrev
""""""""""""""""""""
"Project seting
""""""""""""""""""""
nmap <silent> ;P <Plug>ToggleProject
let g:proj_window_width = 20
let g:proj_window_increment = 50
""""""""""""""""""""
"NERD_commenter setting
""""""""""""""""""""
let g:NERDCreateDefaultMappings=0
call s:CreateMaps('<plug>NERDCommenterComment',    ';xx')
call s:CreateMaps('<plug>NERDCommenterToggle',     ';x<space>')
call s:CreateMaps('<plug>NERDCommenterMinimal',    ';xm')
call s:CreateMaps('<plug>NERDCommenterSexy',       ';xs')
call s:CreateMaps('<plug>NERDCommenterInvert',     ';xi')
call s:CreateMaps('<plug>NERDCommenterYank',       ';xy')
call s:CreateMaps('<plug>NERDCommenterAlignLeft',  ';xl')
call s:CreateMaps('<plug>NERDCommenterAlignBoth',  ';xb')
call s:CreateMaps('<plug>NERDCommenterNest',       ';xn')
call s:CreateMaps('<plug>NERDCommenterUncomment',  ';xu')
call s:CreateMaps('<plug>NERDCommenterToEOL',      ';x$')
call s:CreateMaps('<plug>NERDCommenterAppend',     ';xA')
""""""""""""""""""""
"vcscommand setting
""""""""""""""""""""
let VCSCommandDeleteOnHide=1
""""""""""""""""""""
"errormarker
""""""""""""""""""""
let errormarker_disablemappings = 1
""""""""""""""""""""
"errormarker
""""""""""""""""""""
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="-------------------------------------------"
let g:DoxygenToolkit_blockFooter="-------------------------------------------"
let g:DoxygenToolkit_authorName="Angluca"
let g:DoxygenToolkit_authorEmail="to@angluca.com"
""""""""""""""""""""
"Yankring
""""""""""""""""""""
let g:yankring_history_dir = '$HOME/vimdata/cache'
let g:yankring_max_history = 20
let g:yankring_max_element_length = 1048576 " 1M
let g:yankring_max_display = 20

nmap ;yy :YRShow<CR>
nmap ;yc :YRClear<CR>
""""""""""""""""""""
"EchoFunc
""""""""""""""""""""
"mouse cant show function
let g:EchoFuncAutoStartBalloonDeclaration = 0
"let g:EchoFuncKeyNext=',ew'
"let g:EchoFuncKeyPrev=',er'
""""""""""""""""""""
"vimwiki
""""""""""""""""""""
let	g:vimwiki_use_mouse	=	1
let	g:vimwiki_hl_cb_checked	=	1
let	g:vimwiki_menu	=	''
let	g:vimwiki_CJK_length	=	1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'

let	g:vimwiki_list	=	[{'path':$HOME.'/vimdata/vimwiki/',
			\	'path_html':$HOME.'/vimdata/vimwiki/html/',
			\	'html_header':$HOME.'/vimdata/vimwiki/template/header.tpl',
			\	'html_footer':$HOME.'/vimdata/vimwiki/template/footer.tpl',
			\	'diary_link_count':8}]

""""""""""""""""""""
"linediff
""""""""""""""""""""
nmap	;ld	:Linediff <CR>
vmap	;ld	:Linediff <CR>
nmap	;lr	:LinediffReset <cr>
""""""""""""""""""""
"ColorV
""""""""""""""""""""
let	g:ColorV_cache_File	=	$HOME.'/vimdata/cache/_vim_ColorV_cache'
let	g:ColorV_global_leader	=	';h'
""""""""""""""""""""
"easymotion
""""""""""""""""""""
let g:EasyMotion_keys = 'asdfghjkl;'
let g:EasyMotion_leader_key = '<space>'
""""""""""""""""""""
"syntasic
""""""""""""""""""""
nmap	;sc	:SyntasticCheck<CR>
nmap	;se	:Errors<CR>
nmap	;st	:SyntasticToggleMode<CR>
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': [],
			\ 'passive_filetypes': ['c', 'cpp'] }
""""""""""""""""""""
"vimim
""""""""""""""""""""
let g:vimim_cloud = -1
"let g:vimim_map = ''
"let g:vimim_mode = 'dynamic'
let g:vimim_mycloud = 0
let g:vimim_punctuation = 0
let g:vimim_shuangpin = 0
let g:vimim_toggle = 'wubi'
""""""""""""""""""""
"window move
""""""""""""""""""""
let g:wm_move_up = '<S-Up>'
let g:wm_move_right = '<S-Right>'
let g:wm_move_down = '<S-Down>'
let g:wm_move_left = '<S-Left>'
let g:wm_move_x = 20
let g:wm_move_y = 15
""""""""""""""""""""
"clever-f
""""""""""""""""""""
let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_fix_key_direction = 1
let g:clever_f_show_prompt = 0
""""""""""""""""""""
"airline
""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#whitespace#enabled = 0
""""""""""""""""""""
"clang_complete
""""""""""""""""""""
let g:clang_use_library=1
let g:clang_complete_patterns = 1
let g:clang_snippets = 1
let g:clang_complete_macros = 1
"let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/'
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
"let g:clang_user_options='-stdlib=libc++ -std=c++11'
let g:clang_user_options='-std=c++11'
""""""""""""""
"python-mode
""""""""""""""""""""
let g:pymode_rope_autocomplete_map = '<s-space>'
let g:pymode_run_key = ';pr'
let g:pymode_breakpoint_key = ';pb'
let g:pymode_lint_message = 0
let g:pymode_lint_write = 0
""""""""""""""""""""
"YouCompleteMe
""""""""""""""""""""
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_invoke_completion = '<s-space>'
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_register_as_syntastic_checker = 0

let g:ycm_global_ycm_extra_conf = $VIM .'/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"nmap <silent> \yy :call SwitchToBuf("$VIM/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py")<cr>
""""""""""""""""""""
"vim-markdown
""""""""""""""""""""
"let g:vim_markdown_folding_disabled=1
"
let g:vim_markdown_initial_foldlevel=1
""""""""""""""""""""
"Another plugin mappings
""""""""""""""""""""
"left to right
nmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
vmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
"undo toggle
nmap ;ut :GundoToggle<CR>
"qbuf
let g:qb_hotkey = ";bb"
"EasyAlign
vnoremap <silent> <Enter> :EasyAlign<cr>
"ParameterObject
let g:no_parameter_object_maps = 1
"vmap <silent> ia <Plug>ParameterObjectI
omap <silent> ia <Plug>ParameterObjectI
"vmap <silent> aa <Plug>ParameterObjectA
omap <silent> aa <Plug>ParameterObjectA
"auto pair
let g:AutoPairsShortcutToggle = '<M-a>'

"--------------------------------------------
"load user conf
source $VIMCONF/user.vimrc
nmap <silent> \uu :call SwitchToBuf("$VIMCONF/user.vimrc")<cr>
