vim9script
# -- autocomplete setting --
#inoremap <expr> <BS> pumvisible() ? "\<C-e>\<BS>" : "\<BS>"
set cot=menuone,noinsert,popup,fuzzy
set autocomplete
#set autocompletedelay=60
#set cpt=F,o,k^20,.^20,b^10,w^10,s^20,i^20,t^20,u^10
set cpt=k^10,.^10,b^10,w^10 # lsp下用o或F都会卡
# nim.vim must comment nim#init()
# -- filetypes ------
g:SetFt('*.ctags', 'zsh')
g:SetFt('*.zshrc,*.zprofile', 'zsh')
g:SetFt('*.vim*', 'vim')
g:SetFt('COPYING', 'txt')
g:SetFt('*.txt,*.log', 'txt')
g:SetFt('*.asm,*.inc', 'masm')
g:SetFtCmd('masm', 'setl mp=fasm\ %:p')

g:SetFt('*.glsl,*.[vf]sh,*.vert,*.frag,*.shd,*.wgsl,*.flecs', 'c')
g:SetFt('*.md,*.markdown,README*', 'markdown')
g:SetFt('CMakeLists.txt', 'cmake')
g:SetFt('*.as', 'actionscript')
g:SetFt('*.mxml', 'mxml')
g:SetFt('*.make', 'make')
g:SetFt('*.p', 'pawn')
g:SetFt('*.mm', 'objc')
g:SetFt('*.nut', 'squirrel|setl mp=sq\ %:p')
g:SetFtCmd('squirrel', 'setl efm=%f:%l:%m')
g:SetFt('*.gd', 'gdscript')
g:SetFt('*.tic', 'lua')
g:SetFt('*.wxml', 'html')  # weixin
g:SetFt('*.wxss', 'css')  # wx
g:SetFt('*.nim,*.nims,*.nimble,*.c2nim', 'nim')
g:SetFt('*.zig', 'zig')
g:SetFt('*.lita,*.ape', 'litac')
g:SetFt('*.adept', 'adept')
g:SetFt('*.um,*.td,*.wren', 'ocen')
g:SetFt('*.c3', 'c2')

# automaticlly remove trailing whitespace
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
au BufWrite *.nim**,*.zig,*.d,*.rs :DelTWS

# for language
au FileType c,cpp nmap \== :!ctags --c-kinds=+p --fields=+S -R .<cr>
#au FileType c,cpp setl tags +=$VIMDICT/cpp.tags
#au FileType nim nmap \== :Mctags $VIMDICT/nim.ctags nim.tags<cr>
#au FileType zig $ZIGLIB = $HOME .. '/SDK/Zigs/zig/lib'
#au FileType hare nmap \== :Mctags $VIMDICT/hare.ctags hare.tags<cr>
#au FileType hare $HARELIB = $HOME .. '/SDK/Hares/_hare/src/hare/stdlib'
#au FileType hare $HARESDL = $HOME .. '/Hares/Modules/my_hare-sdl2/sdl'
#au FileType hare setl tags +=$VIMDICT/hare.tags,$VIMDICT/hare.sdl.tags

au FileType mach $MACH_STD = $MACH_ROOT .. '/../mach_std/src'
#au FileType mach nmap \== :Mctags $VIMDICT/mach.local.ctags mach.local.tags<cr>
au FileType mach nmap \== :Mctags $VIMDICT/mach.local.ctags mach.local.tags $MACH_STD<cr>
au FileType mach nmap \=- :Mctags $VIMDICT/mach.ctags mach.tags $MACH_STD<cr>
#call g:SetDict('mach','','mach.base.dict', 'mach.dict', 'mach.raylib.dict')
#call g:SetDict('mach','','mach.base.dict','mach.dict','mach.boom.dict','mach.shader.dict')
g:SetDict('mach', '', 'mach.base.dict')

au FileType spectre $SXLIBS = $SPECTRE_ROOT .. '/spectrelib'
au FileType spectre nmap \== :Mctags $VIMDICT/spectre.ctags spectre.tags<cr>
au FileType spectre nmap \=- :Mctags $VIMDICT/spectre.ctags spectre.tags $SXLIBS<cr>
g:SetTags('spectre', '', 'spectre.tags')
g:SetDict('spectre', '', 'spectre.base.dict', 'spectre.tags')

au FileType nim nmap \== :Maketags ntags -R\ **/**<cr>
au FileType nim $NIMLIB = $HOME .. '/SDK/Nims/nim/lib'
au FileType nim $NIMSKLIB = $HOME .. '/SDK/Nims/nimskull/lib'
g:SetDict('nim', '', 'nim.base.dict')
#g:SetTags('nim','','nim.skull.tags')
g:SetTags('nim', '', 'nim.tags')

au FileType ocen nmap \== :Mctags $VIMDICT/ocen.ctags ocen.tags<cr>
au FileType ocen nmap \=- :Mctags $VIMDICT/ocen.ctags ocen.tags $OCEN_ROOT<cr>
au FileType ocen $OCEN_RAYLIB = $HOME .. '/SDK/Ocens/rylib-ocen/c/include'
#g:SetTags('ocen','$VIM/bundle/ocen.vim/tags','ocen.tags','raylib.tags')
g:SetTags('ocen', '$VIM/bundle/ocen.vim/tags', 'ocen.tags')
#g:SetDict('ocen','$VIM/bundle/ocen.vim/tags','ocen.dict','ocen.base.dict','raylib.dict')
g:SetDict('ocen', '$VIM/bundle/ocen.vim/tags', 'ocen.base.dict')

au FileType rust nmap \== :Maketags ctags --languages=Rust\ --exclude=LICENSE\ --exclude=\*.tags\ --exclude=\*.md\ --exclude=\*.txt\ --exclude=\*.toml\ --exclude=\*.lock\ --exclude=\*.ron\ --exclude=target/\*\ --exclude=examples/\*\ --exclude=code_editor/\*\ --exclude=studio/\*\ --exclude=tools/\*\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust nmap \00 :Mctags $VIMDICT/rust.makepad.dsl.ctags rust.makepad.dsl.tags $MAKEPAD_<cr>
au FileType rust $RUST = $HOME .. '/.Rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library/std'
# 不能用MAKEPAD环境变量,官方为编译提示准备了MAKEPAD=lines
au FileType rust $MAKEPAD_ = $HOME .. '/Rusts/_GUIs/makepad'
#g:SetTags('rust','','rust.tags')
#g:SetDict('rust','','rust.base.dict')
g:SetTags('rust', '', 'rust.tags', 'rust.makepad.tags', 'rust.makepad.dsl.tags')
g:SetDict('rust', '', 'rust.base.dict', 'rust.makepad.dict', 'rust.makepad.dsl.dict')

#%s/.*\/test\/.*$\n//ge
#nmap \-- $RAYLIB
# -- acp dictags ------
# Use nimlsp don't set dict, Will slow !!!
if has('win32')
    g:SetDict('asm', '', 'win32.dict')
    g:SetDict('c,cpp', '', 'win32.dict', 'cpp.dict')
else
    g:SetDict('c,cpp', '', 'cpp.dict')
endif
g:SetDict('vim', '', 'vim.dict')
g:SetDict('java', '', 'java.dict')
g:SetDict('js', '', 'javascript.dict')
g:SetDict('perl', '', 'perl.dict')
g:SetDict('php', '', 'php.dict', 'html.dict')
g:SetDict('html', '', 'javascript.dict', 'html.dict', 'html5.dict')
g:SetDict('actionscript', 'as3.dict')
g:SetDict('sh', '', 'bash.dict')
g:SetDict('squirrel', '', 'squirrel.dict')
g:SetDict('lua', '', 'lua.dict')
g:SetDict('zig', '', 'zig.dict', 'zig.base.dict')
g:SetDict('hare', '', 'hare.base.dict', 'hare.dict', 'hare.sdl.dict')
#-------------------
# temp
au FileType zig g:zig_fmt_autosave = 0

defcompile
