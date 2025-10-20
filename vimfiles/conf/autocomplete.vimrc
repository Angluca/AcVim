"=================================
" auto complete
"=================================
" nim.vim must comment nim#init()
"vimcomplete/plugin/addons.vim must Register('dictionary',['*'],8)
""""""""""""""
" filetypes {{{
""""""""""""""
SetFt('*.ctags','zsh')
SetFt('*.zshrc,*.zprofile','zsh')
SetFt('*.vim*','vim')
SetFt('COPYING','txt')
SetFt('*.txt,*.log','txt')
SetFt('*.asm,*.inc','masm')
SetFtCmd('masm','setl mp=fasm\ %:p')

SetFt('*.glsl,*.vsh,*.fsh,*.vert,*.frag,*.shd,*.flecs','d')
SetFt('*.md,*.markdown,README*','markdown')
SetFt('CMakeLists.txt','cmake')
SetFt('*.as','actionscript')
SetFt('*.mxml','mxml')
SetFt('*.make','make')
SetFt('*.p','pawn')
SetFt('*.mm','objc')
SetFt('*.nut','squirrel')
SetFtCmd('squirrel','setl mp=sq\ %:p')
SetFtCmd('squirrel','setl efm=%f:%l:%m')
SetFt('*.gd','gdscript')
SetFt('*.tic','lua')
SetFt('*.wxml','html') "weixin
SetFt('*.wxss','css')  "wx
SetFt('*.nim,*.nims,*.c2nim','nim')
SetFt('*.zig','zig')
SetFt('*.oc,*.td','ocen')
SetFt('*.lita,*.ape','litac') 
SetFt('*.adept','adept')
SetFt('*.um','ocen')
SetFt('*.wren','ocen')
SetFt('*.c3','c2')

" automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
"SetFtCmd('*.nim,*.nims,*.zig','DelTWS','BufWrite')
au BufWrite *.nim**,*.zig,*.d,*.rs,*.ha,*.c2 :DelTWS

"for language
au FileType c,cpp nmap \== :!ctags --c-kinds=+p --fields=+S -R .
"au FileType c,cpp setl tags +=$VIMDICT/cpp.tags
"au FileType nim nmap \== :Mctags $VIMDICT/nim.ctags nim.tags<cr>
"au FileType nim let $NIMLIB = $HOME.'/SDK/Nims/nim/lib'
"au FileType zig let $ZIGLIB = $HOME.'/SDK/Zigs/zig/lib'
"au FileType hare nmap \== :Mctags $VIMDICT/hare.ctags hare.tags<cr>
"au FileType hare let $HARELIB = $HOME.'/SDK/Hares/_hare/src/hare/stdlib'
"au FileType hare let $HARESDL = $HOME.'/Hares/Modules/my_hare-sdl2/sdl'
"au FileType hare setl tags +=$VIMDICT/hare.tags,$VIMDICT/hare.sdl.tags

"au FileType c2 nmap \== :exe ':silent !ctags --options=$VIMDICT/c2.ctags  -R -f c2.tags' <cr>
au FileType c2 nmap \== :Mctags $VIMDICT/c2.ctags c2.tags<cr>
au FileType c2 nmap \=- :Mctags $VIMDICT/c2.ctags c2.tags $C2_LIBDIR<cr>
au FileType c2 let $C2_LIBS = $HOME.'/SDK/C2langs/c2_libs'
SetTags('c2','','c2.tags', 'c2.libs.tags')
"SetDict('c2','','c2.base.dict','c2.dict')
SetDict('c2','','c2.base.dict')

au FileType ocen nmap \== :Mctags $VIMDICT/ocen.ctags ocen.tags<cr>
au FileType ocen nmap \=- :Mctags $VIMDICT/ocen.ctags ocen.tags $OCEN_ROOT<cr>
au FileType ocen let $OCEN_RAYLIB = $HOME.'/SDK/Ocens/raylib-ocen/c/include'
SetTags('ocen','$VIM/bundle/ocen.vim/tags/','ocen.tags','raylib.tags')
"SetDict('ocen','$VIM/bundle/ocen.vim/tags/','ocen.dict','ocen.base.dict','raylib.dict')
SetDict('ocen','$VIM/bundle/ocen.vim/tags/','ocen.base.dict')

au FileType virgil nmap \== :Maketags vctags **/**/*.v3 tags<cr>
"au FileType virgil nmap \== :!vctags rt/**/*.v3 lib/**/*.v3 aeneas/src/**/*.v3
"au FileType virgil nmap \== :!vctags **/**/*.v3<cr>
SetTags('virgil','','virgil.tags','virgil.rt.tags','virgil.wizeng.tags')

au FileType adept nmap \== :Mctags $VIMDICT/adept.ctags adept.tags<cr>
au FileType adept nmap \=- :Mctags $VIMDICT/adept.ctags adept.tags $ADEPT<cr>
au FileType adept let $ADEPT = $HOME.'/SDK/Adepts/_bin/import'
SetTags('adept','$VIM/bundle/adept.vim/tags/','adept.tags')
SetDict('adept','$VIM/bundle/adept.vim/tags/','adept.dict','adept.base.dict')

"au FileType rust nmap \== :Maketags ctags --rust-kinds=+\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust nmap \== :Maketags ctags --rust-kinds=+\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust let $RUST = $HOME.'/.Rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library/std'
SetTags('rust','','rust.tags')
SetDict('rust','','rust.dict','rust.base.dict')

"%s/.*\/test\/.*$\n//ge
"nmap \-- $RAYLIB

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
	SetDict('asm','','win32.dict')
    SetDict('c,cpp','','win32.dict','cpp.dict')
else
    SetDict('c,cpp','','cpp.dict','flecs.dict')
endif
SetDict('vim','','vim.dict')
SetDict('java','','java.dict')
SetDict('js','','javascript.dict')
SetDict('perl','','perl.dict')
SetDict('php','','php.dict','html.dict')
SetDict('html','','javascript.dict','html.dict','html5.dict')
SetDict('actionscript','as3.dict')
SetDict('sh','','bash.dict')
SetDict('squirrel','','squirrel.dict')
SetDict('lua','','lua.dict')
SetDict('nim','','nim.dict','nim2.dict','nim.enums.dict')
SetDict('zig','','zig.dict','zig.base.dict')
SetDict('hare','','hare.base.dict', 'hare.dict', 'hare.sdl.dict')
"SetDict('ocen','','ocen.base.dict','ocen.dict','raylib.dict')
SetDict('virgil','','virgil.dict','virgil.base.dict')
"}}}
"-------------------
"--temp {{{
au FileType zig let g:zig_fmt_autosave = 0
"raylib
"au FileType zig let $RAYLIB = $HOME.'/SDK/Raylibs/raylib/zig-out/include'
""au FileType zig let $RAYGUI = $HOME.'/SDK/Raylibs/raygui/src'
"au FileType zig setl tags +=$VIMDICT/raylib.tags
"SetDict('zig','','zig.dict','zig.base.dict','raylib.dict')
"sokol
"au FileType zig let $SOKOLC = $HOME.'/Zigs/Sokols/sokol'
"au FileType zig setl tags+=$VIMDICT/sokolc.tags
"au FileType zig let $SOKOL = $HOME.'/Zigs/Sokols/sokol-zig/src/sokol'
"au FileType zig setl tags+=$VIMDICT/sokol-zig.tags
"SetDict('zig','','zig.dict','zig.base.dict','sokol.dict')
"
"au FileType nim let $SOKOL = $HOME.'/Nims/Sokols/sokol-nim/src/sokol'
"au FileType nim setl tags+=$VIMDICT/sokoltags
"SetDict('nim','','nim.dict','nim2.dict','nim.enums.dict','sokol.dict')
""nico
"au FileType nim let $NICO = $HOME.'/Nims/nicos/nico/nico'
"au FileType nim setl tags+=$VIMDICT/nicotags
"SetDict('nim','','nim.dict','nim2.dict','nim.enums.dict','nico.dict')
"-------------------
"--naylib
"au FileType nim let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"let $NAYLIB = $HOME.'/Nims/Raylibs/naylib/src/'
"au FileType nim setl tags+=$VIMDICT/naytags
"SetDict('nim','','nimtags','nim.dict','nim.enums.dict',$NAYLIB.'raylib.nim')
"}}}

