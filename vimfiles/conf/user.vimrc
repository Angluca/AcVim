"=================================
" Plugin configuration
"=================================
""""""""""""""""""""
"Sketch seting
""""""""""""""""""""
nmap <F10> :call ToggleSketch()<CR>
"imap <F10> <esc>
""""""""""""""""""""
"ShowMarks seting
""""""""""""""""""""
let showmarks_include = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_ignore_type="hmpq"    "help,non-modify,preview,quick-fix buffer do not display
"<leader>mt ShowMarksToggle
"<leader>mo ShowmarksShowMarksOn
"<leader>mc ShowmarksClearMark
"<leader>ma ShowmarksClearAll
"<leader>mm ShowmarksPlaceMark
""""""""""""""""""""
"Project seting
""""""""""""""""""""
nmap <silent> ;P <Plug>ToggleProject
let g:proj_window_width = 20
let g:proj_window_increment = 50
""""""""""""""""""""
"errormarker
""""""""""""""""""""
let errormarker_disablemappings = 1
""""""""""""""""""""
"DoxygenToolkit
""""""""""""""""""""
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="-------------------------------------------"
let g:DoxygenToolkit_blockFooter="-------------------------------------------"
let g:DoxygenToolkit_authorName="name"
let g:DoxygenToolkit_authorEmail="my@mail"
""""""""""""""""""""
"EchoFunc
""""""""""""""""""""
"mouse cant show function
let g:EchoFuncAutoStartBalloonDeclaration = 0
"let g:EchoFuncKeyNext=',ew'
"let g:EchoFuncKeyPrev=',er'
""""""""""""""""""""
"qbuf
""""""""""""""""""""
let g:qb_hotkey = ";bb"
""""""""""""""""""""
"fliplr
""""""""""""""""""""
nmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
vmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>

"-------------------------
"bundle plugins
"-------------------------
""""""""""""""""""""
"Ctrlp setting
""""""""""""""""""""
"let g:ctrlp_by_filename = 0
"let g:ctrlp_use_caching = 1
"let g:ctrlp_lazy_update = 0
"let g:ctrlp_regexp = 0
"let g:ctrlp_follow_symlinks = 0
"let g:ctrlp_types = ['fil', 'buf', 'mru'].
"let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
						  "\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir']
let g:ctrlp_arg_map = 1
let g:ctrlp_tilde_homedir = 1
"let g:ctrlp_mruf_include = '\.c$\|\.h$'
"let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_cache_dir = $HOME.'/vimdata/ctrlp'
let g:ctrlp_max_files = 666
let g:ctrlp_mruf_max = 66
let g:ctrlp_max_depth = 44
"let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_switch_buffer = 'Etvh'
let g:ctrlp_open_new_file = 't' "thvr
let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(swp|exe|so|dll|zip|rar|tags|tar|7z)$',
			\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
			\ }

let g:ctrlp_map = ';cc'
nmap <silent> ;cC :CtrlPChangeAll<cr>
nmap <silent> ;cb :CtrlPBuffer<cr>
nmap <silent> ;cm :CtrlPMRUFiles<cr>
nmap <silent> ;cg :CtrlPTag<cr>
nmap <silent> ;cG :CtrlPBufTagAll<cr>
nmap <silent> ;ci :CtrlPDir<cr>
nmap <silent> ;cI :CtrlPBookmarkDir<cr>
nmap <silent> ;cr :CtrlPRTS<cr>
nmap <silent> ;cu :CtrlPUndo<cr>
nmap <silent> ;cx :CtrlPQuickfix<cr>
nmap <silent> ;ca :CtrlPMixed<cr>
nmap <silent> ;cl :CtrlPLine<cr>
nmap <silent> ;cd :CtrlPClearCache<cr>
nmap <silent> ;cD :CtrlPClearAllCaches<cr>
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
"Omnicppcompl setting
""""""""""""""""""""
if has("win32")
	"au FileType c,cpp set tags +=$VIMDICT/winxtags
endif
au FileType c,cpp set tags +=$VIMDICT/cpptags

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
"so $VIMCONF/vneocomplete.conf
"nmap <silent> \nn :call SwitchToBuf("$VIMCONF/neocomplete.vimrc")<cr>
""""""""""""""""""""
"NERDTree seting
""""""""""""""""""""
"let NERDTreeMinimalUI=1
"let NERDTreeMinimalMenu=1
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=0
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.o$', '\~$','\.a$','\.bak$','\.d$','\.ncb$','\.bmp$','\.exe$','\.tar\.gz$','\.7z$','\.zip$','\.rar$','\.swp$','\.dll$','\.obj$']
nmap <silent> ;tt :NERDTreeToggle <cr>
""""""""""""""""""""
"Mark seting
""""""""""""""""""""
nmap <silent> ;mm <Plug>MarkSet
vmap <silent> ;mm <Plug>MarkSet
nmap <silent> ;mr <Plug>MarkRegex
vmap <silent> ;mr <Plug>MarkRegex
nmap <silent> ;mc <Plug>MarkClear
nmap <silent> ;mC <Plug>MarkAllClear
nmap <silent> ;mt <Plug>MarkToggle

nmap <silent> ;* <Plug>MarkSearchCurrentNext
nmap <silent> ;# <Plug>MarkSearchCurrentPrev
nmap <silent> ;/ <Plug>MarkSearchAnyNext
nmap <silent> ;? <Plug>MarkSearchAnyPrev
nmap <silent> * <Plug>MarkSearchNext
nmap <silent> # <Plug>MarkSearchPrev
""""""""""""""""""""
"NERD_commenter setting
""""""""""""""""""""
let g:NERDCreateDefaultMappings=0
call AcCreateMaps('<plug>NERDCommenterComment',    ';xx')
call AcCreateMaps('<plug>NERDCommenterToggle',     ';x<space>')
call AcCreateMaps('<plug>NERDCommenterMinimal',    ';xm')
call AcCreateMaps('<plug>NERDCommenterSexy',       ';xs')
call AcCreateMaps('<plug>NERDCommenterInvert',     ';xi')
call AcCreateMaps('<plug>NERDCommenterYank',       ';xy')
call AcCreateMaps('<plug>NERDCommenterAlignLeft',  ';xl')
call AcCreateMaps('<plug>NERDCommenterAlignBoth',  ';xb')
call AcCreateMaps('<plug>NERDCommenterNest',       ';xn')
call AcCreateMaps('<plug>NERDCommenterUncomment',  ';xu')
call AcCreateMaps('<plug>NERDCommenterToEOL',      ';x$')
call AcCreateMaps('<plug>NERDCommenterAltDelims',  ';xa')
call AcCreateMaps('<plug>NERDCommenterAppend',     ';xA')
""""""""""""""""""""
"vcscommand setting
""""""""""""""""""""
let VCSCommandDeleteOnHide=1
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
"easymotion
""""""""""""""""""""
"let g:EasyMotion_keys = 'asdfghjkl;'
let g:EasyMotion_leader_key = '<space>'
let g:EasyMotion_startofline = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 0
let g:EasyMotion_enter_jump_first = 1
""""""""""""""""""""
"EasyAlign
""""""""""""""""""""
vnoremap <silent> <Enter> :EasyAlign<cr>

""""""""""""""""""""
"syntasic
""""""""""""""""""""
"nmap	;sc	:SyntasticCheck<CR>
"nmap	;se	:Errors<CR>
"nmap	;st	:SyntasticToggleMode<CR>
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
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#show_close_button = 0
""""""""""""""""""""
"clang_complete
""""""""""""""""""""
let g:clang_use_library=1
let g:clang_complete_patterns = 1
let g:clang_snippets = 1
let g:clang_complete_macros = 1
"let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/'
if has("win32")
	let g:clang_library_path='D:/Develop/tools/clang3.3/'
else
	let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
endif
"let g:clang_user_options='-stdlib=libc++ -std=c++11'
let g:clang_user_options='-std=c++11'
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
""""""""""""""""""""
"vim-markdown
""""""""""""""""""""
"let g:vim_markdown_folding_disabled=1
"
let g:vim_markdown_initial_foldlevel=3

""""""""""""""""""""
"lightline
""""""""""""""""""""
set laststatus=2
let g:lightline = {
	  \ 'colorscheme': 'jellybeans',
	  \ }
""""""""""""""""""""
"undotree
""""""""""""""""""""
"let g:undotree_RelativeTimestamp = 0
"let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3
nmap ;ut :UndotreeToggle<cr>:UndotreeFocus<cr>
nmap ;uu :UndotreeToggle<cr>

"-------------------------
"Custom settings
"You can see AcVim maps
":verbose nmap ;
":verbose nmap ,
"-------------------------
"auto-pair
"let g:AutoPairsShortcutToggle = '<M-a>'



