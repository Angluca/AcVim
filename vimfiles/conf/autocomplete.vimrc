"=================================
" auto complete
"=================================
" nim.vim must comment nim#init()
""""""""""""""
" filetypes {{{
""""""""""""""
SetFiletype('*.vim*', 'vim')
SetFiletype('COPYING', 'txt')
SetFiletype('*.txt,*.log', 'txt')
SetFiletype('*.asm', 'masm')
SetFiletype('*.inc', 'masm')
SetFtCmd('masm', 'setl mp=fasm\ %:p')

SetFiletype('*.mxml', 'mxml')
SetFiletype('*.as', 'actionscript')
SetFiletype('CMakeLists.txt', 'cmake')
SetFiletype('*.make', 'make')
SetFiletype('*.p', 'pawn')
SetFiletype('*.md,*.markdown,README*', 'markdown')
SetFiletype('*.shd,*.sc', 'glsl')
SetFiletype('*.mm', 'objc')
"squirrel script
SetFiletype('*.nut', 'squirrel')
SetFtCmd('squirrel', 'setl mp=sq\ %:p')
SetFtCmd('squirrel', 'setl efm=%f:%l:%m')
"godot script
SetFiletype('*.gd', 'gdscript')
"weixin
SetFiletype('*.wxml', 'html')
SetFiletype('*.wxss', 'css')
"nim
SetFiletype('*.nim*,*.c2nim,*.snip', 'nim')

" automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
"SetFtCmd('*.nim,*.nims,*.zig','DelTWS','BufWrite')
au BufWrite *.nim,*.nims,*.zig :DelTWS

"for language
au FileType nim nmap \= :Mtags nimtags $VIMDICT/nim.ctags<cr>
au FileType nim let $NIMLIB = $HOME.'/SDK/nims/nim/lib'
au FileType nim setl tags+=$VIMDICT/nimtags,nimtags
au FileType c,cpp setl tags +=$VIMDICT/cpptags
au FileType zig let $ZIGLIB = $HOME.'/SDK/zigs/zig/lib'
au FileType zig setl tags +=$VIMDICT/zigtags

"nmap \- :Ftags '$ZIGLIB'<cr> 
nmap \- :Ftags '$NIMLIB'<cr> 

"}}}
""""""""""""""
" easycomplete {{{
""""""""""""""
let g:easycomplete_diagnostics_enable = 0
let g:easycomplete_lsp_checking = 0
"let g:easycomplete_maxlength = 16

"noremap <m-i> :EasyCompleteReference<CR>
"noremap <m-o> :BackToOriginalBuffer<CR>
"noremap <c-]> :EasyCompleteGotoDefinition<CR>
"noremap ,en :EasyCompleteRename<CR>
"nnoremap <silent> <C-k> :EasyCompleteNextDiagnostic<CR>
"nnoremap <silent> <C-j> :EasyCompletePreviousDiagnostic<CR>
"let g:easycomplete_tab_trigger="<m-tab>"
"let g:easycomplete_shift_tab_trigger="<m-s-tab>"
"let g:easycomplete_tabnine_enable = 0
"let g:easycomplete_tabnine_config = {
		"\ 'line_limit': 1000,
		"\ 'max_num_result' : 10,
		"\ }
"}}}
""""""""""""""
" acp option {{{
""""""""""""""
"-- vim-auto-popmenu ---
let g:apc_enable_tab = 0
let g:apc_min_length = 2
let g:apc_enable_ft = {'*':1}
set cot=menu,menuone,noselect

"---------------
let g:acp_behaviorKeywordLength=2
"let g:acp_behaviorSnipmateLength = 1
let g:acp_behaviorFileLength = 1
"let g:acp_behaviorUserDefinedFunction = ''
"let g:acp_behaviorUserDefinedMeets = ''
"let g:acp_behaviorKeywordCommand = "\<C-n>"
"let g:acp_behaviorKeywordIgnores = []
"let g:acp_behavior = {}

let g:acp_enableAtStartup = 1
let g:acp_ignorecaseOption = 1
"let g:acp_mappingDriven = 1
"let g:acp_completeoptPreview = 1
"let g:acp_completeOption='.,k,b,w,u,t,i,d'
"let g:acp_completeOption='.,k,b,w,u,t'
let g:acp_completeOption='.,k,b,w'
exe 'set cpt=' . g:acp_completeOption
"set cpt=.,w,b,u,t,k "单,k'可扫描所有dict的文件, 可以k+文件但没有必要
".. 当前缓冲区
"w. 其它窗口的缓冲区
"b. 其它载入的缓冲区
"u. 卸载的缓冲区
"t. 标签
"i. 头文件
"d. 头文件里定义或宏
"k. 扫描dict包含的所有文件
"k. 只扫单,多个文件: k./file, k./*
"}}}
""""""""""""""""""""
" acp dictags {{{
""""""""""""""""""""
" Use nimlsp don't set dict, Will slow !!!
if has("win32")
	SetAcpDict('asm', 'win32.dict')
	SetAcpDict('c,cpp','win32.dict','c.dict','cpp.dict')
else
	SetAcpDict('c,cpp', 'c.dict','cpp.dict')
endif
SetAcpDict('java', 'java.dict')
SetAcpDict('js', 'javascript.dict')
SetAcpDict('vim', 'vim.dict')
SetAcpDict('perl', 'perl.dict')
SetAcpDict('php', 'php.dict','html.dict')
SetAcpDict('html', 'javascript.dict','html.dict','html5.dict')
SetAcpDict('actionscript', 'as3.dict')
SetAcpDict('sh', 'bash.dict')
SetAcpDict('squirrel', 'squirrel.dict')
SetAcpDict('lua', 'lua.dict')
SetAcpDict('zig', 'zigtags')
SetAcpDict('nim', 'nimtags','nim.dict','nim_enums.dict')
"SetAcpDict('nim','nim.dict','nim2.dict','nim_enums.dict')
"}}}
"-------------------
"nico
au FileType nim let $NICO = $HOME.'/Nims/nicos/nico/nico'
au FileType nim setl tags+=$VIMDICT/nicotags
SetAcpDict('nim', 'nimtags','nim.dict','nim_enums.dict','nico.dict')
"SetAcpDict('nim','nim.dict','nim2.dict','nim_enums.dict','nico.dict')
"-------------------
"naylib
"au FileType nim let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"au FileType nim setl tags+=$VIMDICT/naytags
"SetAcpDict('nim','nimtags','nim.dict','nim_enums.dict',$NAYLIB.'raylib.nim')
" zig --
au FileType zig let g:zig_fmt_autosave = 0
