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
SetFt('*.nim,*.nims,*.nimble,*.c2nim','nim')
SetFt('*.zig','zig')
SetFt('*.oc,*.td','ocen')
SetFt('*.lita,*.ape','litac') 
SetFt('*.adept','adept')
SetFt('*.um','ocen')
SetFt('*.wren','ocen')
SetFt('*.c3','c2')

" automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
au BufWrite *.nim**,*.zig,*.d,*.rs,*.ha,*.c2 :DelTWS

"for language
au FileType c,cpp nmap \== :!ctags --c-kinds=+p --fields=+S -R .<cr>
"au FileType c,cpp setl tags +=$VIMDICT/cpp.tags
"au FileType nim nmap \== :Mctags $VIMDICT/nim.ctags nim.tags<cr>
"au FileType zig let $ZIGLIB = $HOME.'/SDK/Zigs/zig/lib'
"au FileType hare nmap \== :Mctags $VIMDICT/hare.ctags hare.tags<cr>
"au FileType hare let $HARELIB = $HOME.'/SDK/Hares/_hare/src/hare/stdlib'
"au FileType hare let $HARESDL = $HOME.'/Hares/Modules/my_hare-sdl2/sdl'
"au FileType hare setl tags +=$VIMDICT/hare.tags,$VIMDICT/hare.sdl.tags

au FileType nature nmap \== :Mctags $VIMDICT/nature.ctags nature.tags<cr>
au FileType nature nmap \=- :Mctags $VIMDICT/nature.ctags nature.tags $NATURE_STD<cr>
au FileType nature let $NATURE_STD = $NATURE_ROOT.'/std'
SetTags('nature','','nature.tags')
SetDict('nature','','nature.base.dict')

au FileType nim nmap \== :Maketags ntags -R\ **/**<cr>
au FileType nim let $NIMLIB = $HOME.'/SDK/Nims/nim/lib'
au FileType nim let $NIMSKLIB = $HOME.'/SDK/Nims/nimskull/lib'
SetDict('nim','','nim.base.dict')
"SetTags('nim','','nim.skull.tags')
SetTags('nim','','nim.tags')

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

au FileType rust nmap \== :Maketags ctags --languages=Rust\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust let $RUST = $HOME.'/.Rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library/std'
SetTags('rust','','rust.tags')
SetDict('rust','','rust.base.dict')

"%s/.*\/test\/.*$\n//ge
"nmap \-- $RAYLIB

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
"}}}

