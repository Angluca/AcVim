"=================================
" auto complete
"=================================
" nim.vim must comment nim#init()
""""""""""""""
" filetypes {{{
""""""""""""""
SetFiletype('*.vimbp,*.vimspec', 'vim')
SetFiletype('README*,COPYING', 'txt')
SetFiletype('*.txt,*.log', 'txt')
SetFiletype('*.asm', 'masm')
SetFiletype('*.inc', 'masm')
SetFtCmd('masm', 'setl mp=fasm\ %:p')

SetFiletype('*.mxml', 'mxml')
SetFiletype('*.as', 'actionscript')
SetFiletype('CMakeLists.txt', 'cmake')
SetFiletype('*.make', 'make')
SetFiletype('*.p', 'pawn')
SetFiletype('*.md,*.markdown', 'markdown')
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
SetFiletype('*.nim,*.nims,*.c2nim', 'nim')

" automaticlly remove trailing whitespace
"au BufWrite *.txt call DelTWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
"SetFtCmd('*.nim,*.nims,*.zig','DelTWS','BufWrite')
au BufWrite *.nim,*.nims,*.zig :DelTWS

"for language
au FileType nim nmap \= :Mtags nimtags $VIMDICT/nim.ctags<cr>
au FileType nim let $NIMLIB = $HOME.'/SDK/nims/nim/lib'
"au FileType nim setl tags+=$VIMDICT/nimtags,nimtags
au FileType c,cpp setl tags +=$VIMDICT/cpptags
au FileType zig let $ZIGLIB = $HOME.'/SDK/zigs/zig/lib'
au FileType zig setl tags +=$VIMDICT/zigtags
"}}}
""""""""""""""
" easycomplete {{{
""""""""""""""
let g:easycomplete_diagnostics_enable = 0
let g:easycomplete_lsp_checking = 0
"let g:easycomplete_first_complete_hit = 0
noremap <c-i> :EasyCompleteReference<CR>
"noremap <c-]> :EasyCompleteGotoDefinition<CR>
"noremap ,en :EasyCompleteRename<CR>
noremap <c-[> :BackToOriginalBuffer<CR>
"nnoremap <silent> <C-k> :EasyCompleteNextDiagnostic<CR>
"nnoremap <silent> <C-j> :EasyCompletePreviousDiagnostic<CR>
"let g:easycomplete_tab_trigger="<c-n>"
"let g:easycomplete_shift_tab_trigger="<c-p>"
"let g:easycomplete_tabnine_enable = 0
"let g:easycomplete_tabnine_config = {
		"\ 'line_limit': 1000,
		"\ 'max_num_result' : 10,
		"\ }
"}}}
""""""""""""""
" acp option {{{
""""""""""""""
"-- easycomplete ---
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
"let g:acp_completeOption='.,w,b,u,t,i,d,k'
let g:acp_completeOption='.,b,u,t,k'
exe 'set cpt=' . g:acp_completeOption
"set cpt=.,w,b,u,t,k
".. 当前缓冲区
"w. 其它窗口的缓冲区
"b. 其它载入的缓冲区
"u. 卸载的缓冲区
"t. 标签
"i. 头文件
"d. 头文件里定义或宏
"k. 文件
"}}}
""""""""""""""""""""
" acp dictags {{{
""""""""""""""""""""
" Use nimlsp don't set dict, Will slow !!!
if has("win32")
	SetAcpDict('asm', $VIMDICT.'win32.dict')
	SetAcpDict('c,cpp','.,w,b,u,i,k'.$VIMDICT.'win32.dict,k'.$VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict', 1)
else
	SetAcpDict('c,cpp', $VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict')
endif
SetAcpDict('java', $VIMDICT.'java.dict')
SetAcpDict('js', $VIMDICT.'javascript.dict')
SetAcpDict('vim', $VIMDICT.'vim.dict')
SetAcpDict('perl', $VIMDICT.'perl.dict')
SetAcpDict('php', $VIMDICT.'php.dict,k'.$VIMDICT.'html.dict')
SetAcpDict('html', $VIMDICT.'javascript.dict,k'.$VIMDICT.'html.dict,k'.$VIMDICT.'html5.dict')
SetAcpDict('actionscript', $VIMDICT.'as3.dict')
SetAcpDict('sh', $VIMDICT.'bash.dict')
"au BufNewFile,BufRead *.nut let g:acp_completeOption= $VIMDICT.'squirrel.dict'
SetAcpDict('squirrel', $VIMDICT.'squirrel.dict')
SetAcpDict('lua', $VIMDICT.'lua.dict')
SetAcpDict('zig', $VIMDICT.'zigtags')
"SetAcpDict('nim', $VIMDICT.'nimtags,k'.$VIMDICT.'nim.dict,k'.$VIMDICT.'nim_enums.dict')
"SetAcpDict('nim', $VIMDICT.'nim.dict')
"SetAcpDict('nim','.,w,b,u,t,i,k', 1)
"SetAcpDict('nim')
"}}}
"-------------------
"nico
au FileType nim let $NICO = $HOME.'/Nims/nicos/nico/nico'
"au FileType nim setl tags+=$VIMDICT/nicotags
"SetAcpDict('nim', $VIMDICT.'nim.dict,k'.$VIMDICT.'nim2.dict,k'.$VIMDICT.'nim_enums.dict,k'.$VIMDICT.'nico.dict')
"SetAcpDict('nim', $VIMDICT.'nimtags,k'.$VIMDICT.'nim.dict,k'.$VIMDICT.'nim_enums.dict,k'.$VIMDICT.'nico.dict')
"-------------------
"naylib
"au FileType nim let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"au FileType nim setl tags+=$VIMDICT/naytags
"SetAcpDict('nim', $VIMDICT.'nimtags,k'.$VIMDICT.'nim.dict,k'.$VIMDICT.'nim_enums.dict,k'.$NAYLIB.'raylib.nim')
