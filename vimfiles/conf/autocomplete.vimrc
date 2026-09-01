"=================================
" auto complete
"=================================
" nim.vim must comment nim#init()
"vimcomplete/plugin/addons.vim must Register('dictionary',['*'],8)
""""""""""""""
" filetypes
""""""""""""""
call g:SetFt('*.ctags','zsh')
call g:SetFt('*.zshrc,*.zprofile','zsh')
call g:SetFt('*.vim*','vim')
call g:SetFt('COPYING','txt')
call g:SetFt('*.txt,*.log','txt')
call g:SetFt('*.asm,*.inc','masm')
call g:SetFtCmd('masm','setl mp=fasm\ %:p')

call g:SetFt('*.glsl,*.[vf]sh,*.vert,*.frag,*.shd,*.wgsl,*.flecs','c')
call g:SetFt('*.md,*.markdown,README*','markdown')
call g:SetFt('CMakeLists.txt','cmake')
call g:SetFt('*.as','actionscript')
call g:SetFt('*.mxml','mxml')
call g:SetFt('*.make','make')
call g:SetFt('*.p','pawn')
call g:SetFt('*.mm','objc')
call g:SetFt('*.nut','squirrel|setl mp=sq\ %:p')
call g:SetFtCmd('squirrel','setl efm=%f:%l:%m')
call g:SetFt('*.gd','gdscript')
call g:SetFt('*.tic','lua')
call g:SetFt('*.wxml','html') "weixin
call g:SetFt('*.wxss','css')  "wx
call g:SetFt('*.nim,*.nims,*.nimble,*.c2nim','nim')
call g:SetFt('*.zig','zig')
call g:SetFt('*.lita,*.ape','litac') 
call g:SetFt('*.adept','adept')
call g:SetFt('*.um,*.td,*.wren','ocen')
call g:SetFt('*.c3','c2')

" automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
au BufWrite *.nim**,*.zig,*.d,*.rs :DelTWS

"for language
au FileType c,cpp nmap \== :!ctags --c-kinds=+p --fields=+S -R .<cr>
"au FileType c,cpp setl tags +=$VIMDICT/cpp.tags
"au FileType nim nmap \== :Mctags $VIMDICT/nim.ctags nim.tags<cr>
"au FileType zig let $ZIGLIB = $HOME.'/SDK/Zigs/zig/lib'
"au FileType hare nmap \== :Mctags $VIMDICT/hare.ctags hare.tags<cr>
"au FileType hare let $HARELIB = $HOME.'/SDK/Hares/_hare/src/hare/stdlib'
"au FileType hare let $HARESDL = $HOME.'/Hares/Modules/my_hare-sdl2/sdl'
"au FileType hare setl tags +=$VIMDICT/hare.tags,$VIMDICT/hare.sdl.tags

au FileType mach let $MACH_STD = $MACH_ROOT.'/../mach_std/src'
"au FileType mach nmap \== :Mctags $VIMDICT/mach.local.ctags mach.local.tags<cr>
au FileType mach nmap \== :Mctags $VIMDICT/mach.local.ctags mach.local.tags $MACH_STD<cr>
au FileType mach nmap \=- :Mctags $VIMDICT/mach.ctags mach.tags $MACH_STD<cr>
"call g:SetDict('mach','','mach.base.dict', 'mach.dict', 'mach.raylib.dict')
"call g:SetDict('mach','','mach.base.dict','mach.dict','mach.boom.dict','mach.shader.dict')
call g:SetDict('mach','','mach.base.dict')

au FileType spectre let $SXLIBS = $SPECTRE_ROOT.'/spectrelib'
au FileType spectre nmap \== :Mctags $VIMDICT/spectre.ctags spectre.tags<cr>
au FileType spectre nmap \=- :Mctags $VIMDICT/spectre.ctags spectre.tags $SXLIBS<cr>
call g:SetTags('spectre','','spectre.tags')
call g:SetDict('spectre','','spectre.base.dict', 'spectre.tags')

au FileType nim nmap \== :Maketags ntags -R\ **/**<cr>
au FileType nim let $NIMLIB = $HOME.'/SDK/Nims/nim/lib'
au FileType nim let $NIMSKLIB = $HOME.'/SDK/Nims/nimskull/lib'
call g:SetDict('nim','','nim.base.dict')
"call g:SetTags('nim','','nim.skull.tags')
call g:SetTags('nim','','nim.tags')

au FileType ocen nmap \== :Mctags $VIMDICT/ocen.ctags ocen.tags<cr>
au FileType ocen nmap \=- :Mctags $VIMDICT/ocen.ctags ocen.tags $OCEN_ROOT<cr>
au FileType ocen let $OCEN_RAYLIB = $HOME.'/SDK/Ocens/rylib-ocen/c/include'
"call g:SetTags('ocen','$VIM/bundle/ocen.vim/tags','ocen.tags','raylib.tags')
call g:SetTags('ocen','$VIM/bundle/ocen.vim/tags','ocen.tags')
"call g:SetDict('ocen','$VIM/bundle/ocen.vim/tags','ocen.dict','ocen.base.dict','raylib.dict')
call g:SetDict('ocen','$VIM/bundle/ocen.vim/tags','ocen.base.dict')

au FileType rust nmap \== :Maketags ctags --languages=Rust\ --exclude=LICENSE\ --exclude=\*.tags\ --exclude=\*.md\ --exclude=\*.txt\ --exclude=\*.toml\ --exclude=\*.lock\ --exclude=\*.ron\ --exclude=target/\*\ --exclude=examples/\*\ --exclude=code_editor/\*\ --exclude=studio/\*\ --exclude=tools/\*\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust nmap \00 :Mctags $VIMDICT/rust.makepad.dsl.ctags rust.makepad.dsl.tags $MAKEPAD_<cr>
au FileType rust let $RUST = $HOME.'/.Rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library/std'
" 不能用MAKEPAD环境变量,官方为编译提示准备了MAKEPAD=lines
au FileType rust let $MAKEPAD_ = $HOME.'/Rusts/_GUIs/makepad'
"call g:SetTags('rust','','rust.tags')
"call g:SetDict('rust','','rust.base.dict')
call g:SetTags('rust','','rust.tags','rust.makepad.tags','rust.makepad.dsl.tags')
call g:SetDict('rust','','rust.base.dict','rust.makepad.dict','rust.makepad.dsl.dict')

"%s/.*\/test\/.*$\n//ge
"nmap \-- $RAYLIB

"
""""""""""""""""""""
" acp dictags
""""""""""""""""""""
" Use nimlsp don't set dict,Will slow !!!
if has("win32")
	call g:SetDict('asm','','win32.dict')
    call g:SetDict('c,cpp','','win32.dict','cpp.dict')
else
    call g:SetDict('c,cpp','','cpp.dict')
endif
call g:SetDict('vim','','vim.dict')
call g:SetDict('java','','java.dict')
call g:SetDict('js','','javascript.dict')
call g:SetDict('perl','','perl.dict')
call g:SetDict('php','','php.dict','html.dict')
call g:SetDict('html','','javascript.dict','html.dict','html5.dict')
call g:SetDict('actionscript','as3.dict')
call g:SetDict('sh','','bash.dict')
call g:SetDict('squirrel','','squirrel.dict')
call g:SetDict('lua','','lua.dict')
call g:SetDict('zig','','zig.dict','zig.base.dict')
call g:SetDict('hare','','hare.base.dict', 'hare.dict', 'hare.sdl.dict')
"
"""""""""""""""""""""""""""""
" autocomplete setting
"""""""""""""""""""""""""""""
"set cot=menuone,noinsert,noselect,popup
"set cot=menuone,noinsert,popup  " Not need preview, It is open win
"set cot=menuone,noinsert,longest,popup,fuzzy
"set cot=menuone,noinsert,fuzzy
"set cpt=k^20,.^20,b^10,w^10

set cot=menuone,noinsert,popup,fuzzy
set autocomplete
set cpt=F,o,k^20,.^20,b^10,w^10,s^20,i^20,t^20,u^10
"ino <silent><expr> <C-Space> "\<C-x>\<C-o>"

"-------------------
"--temp
au FileType zig let call g:zig_fmt_autosave = 0

