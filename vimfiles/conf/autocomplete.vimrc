"=================================
" auto complete
"=================================
" nim.vim must comment nim#init()
""""""""""""""
" filetypes {{{
""""""""""""""
SetFiletype('*.ctags','zsh')
SetFiletype('*.zshrc,*.zprofile','zsh')
SetFiletype('*.vim*','vim')
SetFiletype('COPYING','txt')
SetFiletype('*.txt,*.log','txt')
SetFiletype('*.asm,*.inc','masm')
SetFtCmd('masm','setl mp=fasm\ %:p')

SetFiletype('*.glsl,*.vsh,*.fsh,*.vert,*.frag,*.shd,*.flecs','d')
SetFiletype('*.md,*.markdown,README*','markdown')
SetFiletype('CMakeLists.txt','cmake')
SetFiletype('*.as','actionscript')
SetFiletype('*.mxml','mxml')
SetFiletype('*.make','make')
SetFiletype('*.p','pawn')
SetFiletype('*.mm','objc')
SetFiletype('*.nut','squirrel')
SetFtCmd('squirrel','setl mp=sq\ %:p')
SetFtCmd('squirrel','setl efm=%f:%l:%m')
SetFiletype('*.gd','gdscript')
SetFiletype('*.tic','lua')
SetFiletype('*.wxml','html') "weixin
SetFiletype('*.wxss','css')  "wx
SetFiletype('*.nim,*.nims,*.c2nim','nim') "nim
SetFiletype('*.zig','zig') "zig
SetFiletype('*.oc','ocen') "ocen

" automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
"SetFtCmd('*.nim,*.nims,*.zig','DelTWS','BufWrite')
au BufWrite *.nim**,*.zig,*.d,*.rs,*.ha :DelTWS

"for language
au FileType c,cpp nmap \== :!ctags --c-kinds=+p --fields=+S -R .
"au FileType c,cpp setl tags +=$VIMDICT/cpp.tags
"au FileType nim nmap \== :Mtags nim.tags $VIMDICT/nim.ctags<cr>
"au FileType nim let $NIMLIB = $HOME.'/SDK/Nims/nim/lib'
"au FileType zig let $ZIGLIB = $HOME.'/SDK/Zigs/zig/lib'
au FileType hare nmap \== :Mtags hare.tags $VIMDICT/hare.ctags<cr>
"au FileType hare let $HARELIB = $HOME.'/SDK/Hares/_hare/src/hare/stdlib'
"au FileType hare let $HARESDL = $HOME.'/Hares/Modules/my_hare-sdl2/sdl'
"au FileType hare setl tags +=$VIMDICT/hare.tags,$VIMDICT/hare.sdl.tags

au FileType ocen nmap \== :Mtags ocen.tags $VIMDICT/ocen.ctags<cr>
au FileType ocen let $OCENLIB = $HOME.'/SDK/Ocens/ocen/std'
au FileType ocen setl tags +=$VIMDICT/ocen.tags

"nmap \-z :Ftags '$ZIGLIB'<cr> 
"nmap \-n :Ftags '$NIMLIB'<cr> 
"nmap \-r :Ftags '$RAYLIB'<cr> 
"nmap \-h :Ftags '$HAELIB'<cr> 

"}}}
""""""""""""""
" easycomplete {{{
""""""""""""""
"let g:easycomplete_diagnostics_enable = 0
"let g:easycomplete_lsp_checking = 0
""let g:easycomplete_maxlength = 16

"noremap <m-i> :EasyCompleteReference<CR>
"noremap <m-o> :BackToOriginalBuffer<CR>
"noremap <c-]> :EasyCompleteGotoDefinition<CR>
"noremap ,en :EasyCompleteRename<CR>
"nnoremap <silent> <C-k> :EasyCompleteNextDiagnostic<CR>
"nnoremap <silent> <C-j> :EasyCompletePreviousDiagnostic<CR>
"let g:easycomplete_mtab_trigger="<m-tab>"
"let g:easycomplete_shift_tab_trigger="<m-s-tab>"
"let g:easycomplete_tabnine_enable = 0
"let g:easycomplete_tabnine_config = {
		"\ 'line_limit': 1000,
		"\ 'max_num_result' : 10,
		"\ }
"}}}
""""""""""""""
" complete opt {{{
""""""""""""""
"-- vim-auto-popmenu ---
let g:apc_enable_tab = 0
let g:apc_min_length = 1
let g:apc_enable_ft = {'*':1}
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
"set cpt=.,w,b,u,t,k "单,k'可扫描所有dict的文件,可以k+文件但没有必要
".. 当前缓冲区
"w. 其它窗口的缓冲区
"b. 其它载入的缓冲区
"u. 卸载的缓冲区
"t. 标签
"i. 头文件
"d. 头文件里定义或宏
"k. 扫描dict包含的所有文件
"k. 只扫单,多个文件: k./file,k./*
"}}}
""""""""""""""""""""
" acp dictags {{{
""""""""""""""""""""
" Use nimlsp don't set dict,Will slow !!!
if has("win32")
	SetAcpDict('asm','win32.dict')
    SetAcpDict('c,cpp','win32.dict','cpp.dict')
else
    SetAcpDict('c,cpp','cpp.dict','flecs.dict')
endif
SetAcpDict('vim','vim.dict')
SetAcpDict('java','java.dict')
SetAcpDict('js','javascript.dict')
SetAcpDict('perl','perl.dict')
SetAcpDict('php','php.dict','html.dict')
SetAcpDict('html','javascript.dict','html.dict','html5.dict')
SetAcpDict('actionscript','as3.dict')
SetAcpDict('sh','bash.dict')
SetAcpDict('squirrel','squirrel.dict')
SetAcpDict('lua','lua.dict')
SetAcpDict('nim','nim.dict','nim2.dict','nim.enums.dict')
SetAcpDict('zig','zig.dict','zig.base.dict')
SetAcpDict('hare','hare.base.dict', 'hare.dict', 'hare.sdl.dict')
SetAcpDict('ocen','ocen.base.dict','ocen.dict')
"}}}
"-------------------
"--temp {{{
au FileType zig let g:zig_fmt_autosave = 0
"raylib
"au FileType zig let $RAYLIB = $HOME.'/SDK/Raylibs/raylib/src'
"au FileType zig let $RAYGUI = $HOME.'/SDK/Raylibs/raygui/src'
"au FileType zig setl tags +=$VIMDICT/raylib.tags,$VIMDICT/raygui.tags
SetAcpDict('zig','zig.dict','zig.base.dict','raylib.dict','raygui.dict')
"sokol
"au FileType zig let $SOKOLC = $HOME.'/Zigs/Sokols/sokol'
"au FileType zig setl tags+=$VIMDICT/sokolc.tags
"au FileType zig let $SOKOL = $HOME.'/Zigs/Sokols/sokol-zig/src/sokol'
"au FileType zig setl tags+=$VIMDICT/sokol-zig.tags
"SetAcpDict('zig','zig.dict','zig.base.dict','sokol.dict')
"
"au FileType nim let $SOKOL = $HOME.'/Nims/Sokols/sokol-nim/src/sokol'
"au FileType nim setl tags+=$VIMDICT/sokoltags
"SetAcpDict('nim','nim.dict','nim2.dict','nim.enums.dict','sokol.dict')
""nico
"au FileType nim let $NICO = $HOME.'/Nims/nicos/nico/nico'
"au FileType nim setl tags+=$VIMDICT/nicotags
"SetAcpDict('nim','nim.dict','nim2.dict','nim.enums.dict','nico.dict')
"-------------------
"--naylib
"au FileType nim let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"au FileType nim setl tags+=$VIMDICT/naytags
"SetAcpDict('nim','nimtags','nim.dict','nim.enums.dict',$NAYLIB.'raylib.nim')
"}}}
