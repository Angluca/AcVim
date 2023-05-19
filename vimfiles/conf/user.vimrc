"=================================
" Plugin configuration
"=================================
"-------------------------
" plugins {{{
"-------------------------
""""""""""""""""""""
"ShowMarks {{{
""""""""""""""""""""
let showmarks_include = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_ignore_type = "hmpq"    "help,non-modify,preview,quick-fix buffer do not display
"<leader>mt ShowMarksToggle
"<leader>mo ShowmarksShowMarksOn
"<leader>mc ShowmarksClearMark
"<leader>ma ShowmarksClearAll
"<leader>mm ShowmarksPlaceMark
"}}}
""""""""""""""""""""
"errormarker {{{
""""""""""""""""""""
let errormarker_disablemappings = 1
"}}}
""""""""""""""""""""
"EchoFunc {{{
""""""""""""""""""""
"let mouse dont show func = 0
let g:EchoFuncAutoStartBalloonDeclaration = 0
"let g:EchoFuncBallonOnly = 1
"let g:EchoFuncShowOnStatus = 1
let g:EchoFuncKeyNext='<m-=>'
let g:EchoFuncKeyPrev='<m-->'
"use EchoFunc on all file if no set
"let g:EchoFuncLangsUsed = ["java","cpp"]
"let g:EchoFuncPathMappingEnabled = 1
"let g:EchoFuncPathMapping = [
"\ [expand("$VIMDICT") , '$VIMDICT']
"\]
"}}}
""""""""""""""""""""
"qbuf {{{
""""""""""""""""""""
let g:qb_hotkey = ';bb'
"}}}
""""""""""""""""""""
"bufexplorer {{{
""""""""""""""""""""
nmap <silent> ;be :BufExplorer<CR>
nmap <silent> ;bt :ToggleBufExplorer<CR>
nmap <silent> ;bs :BufExplorerHorizontalSplit<CR>
nmap <silent> ;bv :BufExplorerVerticalSplit<CR>
"let g:bufExplorerDefaultHelp=0
"let g:bufExplorerReverseSort=1
"let bufExplorerDetailedHelp=0
"let g:bufExplorerSortBy='number'
"let g:bufExplorerShowUnlisted=1
"let g:bufExplorerShowTabBuffer=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitRight=1
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitHorzSize=6
let g:bufExplorerSplitVertSize=30 
"}}}
""""""""""""""""""""
"fliplr {{{
""""""""""""""""""""
"nmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
vmap ;fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
"}}}
"-------------------
"}}}
"-------------------------
"bundle plugins {{{
"-------------------------
""""""""""""""""""""
"Ctrlp {{{
""""""""""""""""""""
"let g:ctrlp_by_filename = 0
"let g:ctrlp_lazy_update = 0
"let g:ctrlp_regexp = 0
"let g:ctrlp_follow_symlinks = 0
"let g:ctrlp_types = ['fil', 'buf', 'mru'].
"let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
"let g:ctrlp_extensions = ['tag', 'buffertag', 'dir']
let g:ctrlp_arg_map = 1
let g:ctrlp_tilde_homedir = 1
"let g:ctrlp_mruf_include = '\.c$\|\.h$'
"let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_use_caching = 10
let g:ctrlp_cache_dir = $VIMDATA.'ctrlp'
let g:ctrlp_max_files = 666
let g:ctrlp_mruf_max = 66
let g:ctrlp_max_depth = 44
"let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_switch_buffer = 'Etvh'
let g:ctrlp_open_new_file = 't' "thvr
let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 1
"let g:ctrlp_mruf_relative = 0
"let g:ctrlp_custom_ignore = {
"\ 'dir':  '\v[\/]\.(git|hg|svn)$',
"\ 'file': '\v\.(swp|exe|so|dll|zip|rar|tags|tar|7z)$',
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
"\ }

let g:ctrlp_map = ';cc'
nmap <silent> ;cg :CtrlPChangeAll<cr>
nmap <silent> ;cb :CtrlPBuffer<cr>
nmap <silent> ;cm :CtrlPMRUFiles<cr>
nmap <silent> ;cT :CtrlPTag<cr>
nmap <silent> ;ct :CtrlPBufTagAll<cr>
nmap <silent> ;ci :CtrlPDir<cr>
"nmap <silent> ;cm :CtrlPBookmarkDir<cr>
"nmap <silent> ;cM :CtrlPBookmarkDirAdd<cr>
nmap <silent> ;cr :CtrlPRTS<cr>
nmap <silent> ;cu :CtrlPUndo<cr>
nmap <silent> ;cl :CtrlPQuickfix<cr>
nmap <silent> ;ca :CtrlPMixed<cr>
nmap <silent> ;cf :CtrlPLine<cr>
nmap <silent> ;cd :CtrlPClearCache<cr>
nmap <silent> ;cD :CtrlPClearAllCaches<cr>
"}}}
""""""""""""""""""""
"Tagbar (similar taglist) {{{
""""""""""""""""""""
"let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autoclose = 1
let g:tagbar_width = 28
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
"let g:tagbar_sort = 0
"let g:tagbar_expand = 0
"let g:tagbar_singleclick = 1
"let g:tagbar_foldlevel = 2
"let g:tagbar_systemenc = 'gbk'
"let g:tagbar_updateonsave_maxlines = 10000
let g:tagbar_type_nim = {
			\ 'ctagstype' : 'python',
			\ 'kinds'     : [
			\ 'f:func:0:1',
			\ 't:type:1:0',
			\ 'i:iterator:1:0',
			\ 'o:operator:1:0',
			\ 'm:macro:1:0'
			\ ],
			\ 'sort'    : 0,
			\ 'deffile' : expand('<sfile>:p:h:h') . '/dict/nim.ctags'
			\ }
nmap <silent> ;tl :TagbarToggle<cr>
"}}}
""""""""""""""""""""
"NERDTree  {{{
""""""""""""""""""""
"let NERDTreeMinimalUI=1
"let NERDTreeMinimalMenu=1
let NERDTreeQuitOnOpen=1
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=0
"let NERDTreeWinPos='left'
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.o$', '\~$','\.a$','\.bak$','\.d$','\.ncb$','\.bmp$','\.exe$','\.tar\.gz$','\.7z$','\.zip$','\.rar$','\.swp$','\.dll$','\.obj$']
nmap <silent> ;tt :NERDTreeToggle <cr>
"}}}
""""""""""""""""""""
"NERD_commenter {{{
""""""""""""""""""""
"let g:NERDCustomDelimiters = {
"\ 'vim': { 'left': '#' }
"\ }

let g:NERDCreateDefaultMappings=0
AcCreateMaps('<plug>NERDCommenterComment',    ';xx')
AcCreateMaps('<plug>NERDCommenterToggle',     ';x<space>')
AcCreateMaps('<plug>NERDCommenterMinimal',    ';xm')
AcCreateMaps('<plug>NERDCommenterSexy',       ';xs')
AcCreateMaps('<plug>NERDCommenterInvert',     ';xi')
AcCreateMaps('<plug>NERDCommenterYank',       ';xy')
AcCreateMaps('<plug>NERDCommenterAlignLeft',  ';xl')
AcCreateMaps('<plug>NERDCommenterAlignBoth',  ';xb')
AcCreateMaps('<plug>NERDCommenterNest',       ';xn')
AcCreateMaps('<plug>NERDCommenterUncomment',  ';xu')
AcCreateMaps('<plug>NERDCommenterToEOL',      ';x$')
AcCreateMaps('<plug>NERDCommenterAltDelims',  ';xa')
AcCreateMaps('<plug>NERDCommenterAppend',     ';xA')
"}}}
""""""""""""""""""""
"easymotion {{{
""""""""""""""""""""
"let g:EasyMotion_keys= 'asdghklqwertyuiopzxcvbnmfj;'
let g:EasyMotion_keys = 'vcxzbtrewqyuiopnmhgasdfjkl;'
let g:EasyMotion_leader_key = '<space>'
let g:EasyMotion_startofline = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
"let g:EasyMotion_space_jump_first = 0
"let g:EasyMotion_disable_two_key_combo = 0
"let g:EasyMotion_off_screen_search = 0
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)
nmap F <Plug>(easymotion-overwin-f2)
map  <space>f <Plug>(easymotion-bd-fn)
nmap  <space>f <Plug>(easymotion-bd-fn)
map  t <Plug>(easymotion-bd-w)
nmap  t <Plug>(easymotion-overwin-w)
map T <Plug>(easymotion-bd-jk)
nmap T <Plug>(easymotion-overwin-line)
"}}}
""""""""""""""""""""
"incsearch {{{
""""""""""""""""""""
set hlsearch
"let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
"map ? <Plug>(incsearch-stay)

map g/ <Plug>(incsearch-fuzzy-/)
map g? <Plug>(incsearch-fuzzy-/)
"map g? <Plug>(incsearch-fuzzy-stay)

"map <space>/ <Plug>(incsearch-fuzzyword-/)
"map <space>? <Plug>(incsearch-fuzzyword-?)
"map <space>g/ <Plug>(incsearch-fuzzyword-stay)

"--select *find--
vnoremap * y/<c-r>"<cr>

"}}}
""""""""""""""""""""
"EasyAlign {{{
""""""""""""""""""""
vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}
""""""""""""""""""""
"syntasic {{{
""""""""""""""""""""
nmap	;sk	:SyntasticCheck<CR>
nmap	;sl	:Errors<CR>
nmap	;st	:SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive',
\ 'active_filetypes': [],
\ 'passive_filetypes': [] }
"}}}
""""""""""""""""""""
"vimim {{{
""""""""""""""""""""
let g:vimim_cloud = -1
let g:vimim_map = 'no-gi'
"let g:vimim_mode = 'dynamic'
let g:vimim_mycloud = 0
let g:vimim_punctuation = 0
let g:vimim_shuangpin = 0
let g:vimim_toggle = 'wubi'
"}}}
""""""""""""""""""""
"clever-f {{{
""""""""""""""""""""
let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_fix_key_direction = 1
let g:clever_f_show_prompt = 0
"}}}
""""""""""""""""""""
"vim-markdown {{{
""""""""""""""""""""
let g:vim_markdown_fenced_languages = ['bash=sh', 'viml=vim', 'nims=nim', 'ini=dosini']
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_override_foldtext = 0
let g:tex_conceal = ""
let g:vim_markdown_auto_insert_bullets = 0
"let g:vim_markdown_auto_extension_ext = 'txt'
"let g:vim_markdown_math = 1
"let g:vim_markdown_toc_autofit = 0
"let g:vim_markdown_folding_style_pythonic = 1
"let g:vim_markdown_initial_foldlevel=3
"}}}
""""""""""""""""""""
"lightline {{{
""""""""""""""""""""
set laststatus=2
let g:lightline = {'colorscheme': 'jellybeans',}
"}}}
""""""""""""""""""""
"undotree {{{
""""""""""""""""""""
"let g:undotree_RelativeTimestamp = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3
nmap ;ut :UndotreeToggle<cr>
"}}}
""""""""""""""""""""
"elm {{{
""""""""""""""""""""
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1
"}}}
""""""""""""""""""""
"minisnip {{{
""""""""""""""""""""
let g:miniSnip_dirs = [ $VIM.'miniSnips' ]
let g:miniSnip_local = 'miniSnips'
let g:miniSnip_trigger = '<C-j>'
let g:miniSnip_complkey ='<C-x><C-u>' 
"let g:miniSnip_ext = 'snip'
let g:miniSnip_extends = {
			\ 'cpp' : [ 'c' ],
			\ }
"let g:miniSnip_extends['nim'] = [ 'nico' ]
"}}}
""""""""""""""""""""
"AsyncRun&Task {{{
""""""""""""""""""""
"--Run-------------------------"
com! -bang -nargs=* -complete=file Nake AsyncRun<bang> -raw=1 -focus=0 -rows=8 -program=make -auto=make @ <args>
com! -bang -nargs=* -range=% -complete=shellcmd AcRun <range>AsyncRun<bang> -focus=0 -rows=8 -raw=1 <args>
com! -bang -nargs=* -range=% -complete=shellcmd AcUiRun <range>AsyncRun<bang> -mode=term -pos=quickui -raw=1 <args>
let g:asyncrun_open = 8
"let g:asyncrun_auto = 'make'
"let g:asyncrun_last = 3
"let g:asyncrun_mode = 'term'
"let asyncrun_term_hidden = 1
"let g:asyncrun_term_wipe = 1
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.hg', '.vscode', '*.nimble', '*.tasks']
let g:asyncrun_capture_file = $VIMDATA.'cache/capture.tmp'
nmap <space>l :call asyncrun#quickfix_toggle(g:asyncrun_open)<cr>
nmap <space>q :AsyncStop<cr>
nmap <space>Q :AsyncStop!<cr>
nmap <space><space> <esc>

"nmap <space>R :AcRun! 
nmap <space>r :AcRun 
nmap <space>R :AcRun -focus=1 -mode=term -pos=TAB -close=1 zsh<cr>
"&shell
nmap <space>u :AcUiRun 
nmap <space>U :AcUiRun -close=1 zsh<cr>
"let g:asyncrun_wrapper = ''
"let g:asyncrun_shell = '/usr/bin/zsh'
"let g:asyncrun_shellflag = '-c'
"--Tasks-----------------------"
com -nargs=? SetTasks call s:setTasks(<args>)
"------
fu s:setTasks(name='')
	if g:asynctasks_config_name!='.tasks' && a:name==''
		return
	endif
	let l:name = a:name == '' ? &ft.'.tasks' : a:name
	let g:asynctasks_config_name = l:name
	let g:asynctasks_rtp_config = 'tasks/'.l:name
	"let g:asynctasks_extra_config = 'tasks/config.tasks'
endf 
"---
nmap <space>t  :AsyncTask
nmap <space>tt :AsyncTask 
nmap <space>te :AsyncTaskEdit<cr>
nmap <space>tE :AsyncTaskEdit!<cr>
nmap <space>tl :AsyncTaskList<cr>
nmap <space>tL :AsyncTaskList!<cr>
nmap <space>th :AsyncTaskMacro<cr>
nmap <space>tH :AsyncTask -M<cr>
nmap <space>tp :AsyncTaskProfile<cr>
nmap <space>tm :AsyncTask -h<cr>
let g:asynctasks_term_focus = 0
"let g:asynctasks_term_reuse = 1
"let g:asynctasks_term_pos = 'macos'
"let g:asynctasks_term_pos = 'quickui'
let g:asynctasks_term_rows = 6
let g:asynctasks_term_cols = 80
"let g:asynctasks_term_close = 1
let g:quickui_color_scheme = 'papercol'
au FileType * SetTasks 
"au FileType nim SetTasks 'nim.tasks'
"au FileType c,cpp SetTasks 'c.tasks'
"}}}
"-------------------
"}}}
"-------------------------
"Custom settings
"You can see maps
":verbose nmap ;
":verbose nmap ,
"-------------------------
