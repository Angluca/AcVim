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

SetFt('*.glsl,*.[vf]sh,*.vert,*.frag,*.shd,*.wgsl,*.flecs','c')
SetFt('*.md,*.markdown,README*','markdown')
SetFt('CMakeLists.txt','cmake')
SetFt('*.as','actionscript')
SetFt('*.mxml','mxml')
SetFt('*.make','make')
SetFt('*.p','pawn')
SetFt('*.mm','objc')
SetFt('*.nut','squirrel|setl mp=sq\ %:p')
SetFtCmd('squirrel','setl efm=%f:%l:%m')
SetFt('*.gd','gdscript')
SetFt('*.tic','lua')
SetFt('*.wxml','html') "weixin
SetFt('*.wxss','css')  "wx
SetFt('*.nim,*.nims,*.nimble,*.c2nim','nim')
SetFt('*.zig','zig')
SetFt('*.lita,*.ape','litac') 
SetFt('*.adept','adept')
SetFt('*.um,*.td,*.wren','ocen')
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

au FileType dither nmap \== :Mctags $VIMDICT/dither.ctags dither.tags<cr>
au FileType dither nmap \=- :Mctags $VIMDICT/dither.ctags dither.tags $DITHER_ROOT<cr>
"SetTags('dither','','dither.tags')
"SetDict('dither','','dither.dict')

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
au FileType ocen let $OCEN_RAYLIB = $HOME.'/SDK/Ocens/rylib-ocen/c/include'
"SetTags('ocen','$VIM/bundle/ocen.vim/tags','ocen.tags','raylib.tags')
SetTags('ocen','$VIM/bundle/ocen.vim/tags','ocen.tags')
"SetDict('ocen','$VIM/bundle/ocen.vim/tags','ocen.dict','ocen.base.dict','raylib.dict')
SetDict('ocen','$VIM/bundle/ocen.vim/tags','ocen.base.dict')

au FileType virgil nmap \== :Maketags vctags **/**/*.v3 tags<cr>
"au FileType virgil nmap \== :!vctags rt/**/*.v3 lib/**/*.v3 aeneas/src/**/*.v3
"au FileType virgil nmap \== :!vctags **/**/*.v3<cr>
SetTags('virgil','','virgil.tags','virgil.rt.tags','virgil.wizeng.tags')
SetDict('virgil','','virgil.dict','virgil.base.dict')

au FileType adept nmap \== :Mctags $VIMDICT/adept.ctags adept.tags<cr>
au FileType adept nmap \=- :Mctags $VIMDICT/adept.ctags adept.tags $ADEPT<cr>
au FileType adept let $ADEPT = $HOME.'/SDK/Adepts/_bin/import'
SetTags('adept','$VIM/bundle/adept.vim/tags','adept.tags')
SetDict('adept','$VIM/bundle/adept.vim/tags','adept.dict','adept.base.dict')

au FileType rust nmap \== :Maketags ctags --languages=Rust\ --exclude=LICENSE\ --exclude=\*.tags\ --exclude=\*.md\ --exclude=\*.txt\ --exclude=\*.toml\ --exclude=\*.lock\ --exclude=\*.ron\ --exclude=target/\*\ --exclude=examples/\*\ --exclude=code_editor/\*\ --exclude=studio/\*\ --exclude=tools/\*\ --fields=+S\ -R\ -f\ rust.tags rust.tags<cr>
au FileType rust nmap \00 :Mctags $VIMDICT/rust.makepad.dsl.ctags rust.makepad.dsl.tags $MAKEPAD_<cr>
au FileType rust let $RUST = $HOME.'/.Rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library/std'
" 不能用MAKEPAD环境变量,官方为编译提示准备了MAKEPAD=lines
au FileType rust let $MAKEPAD_ = $HOME.'/Rusts/_GUIs/makepad'
"SetTags('rust','','rust.tags')
"SetDict('rust','','rust.base.dict')
SetTags('rust','','rust.tags','rust.makepad.tags','rust.makepad.dsl.tags')
SetDict('rust','','rust.base.dict','rust.makepad.dict','rust.makepad.dsl.dict')

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
"}}}
"""""""""""""""""""""""""""""
" autocomplete setting {{{
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

"setl omnifunc=syntaxcomplete#Complete
"setl omnifunc=SmartTagCompleteHash
"setl completefunc=SmartTagCompleteHash
"au VimEnter * call timer_start(100, {-> execute('call SmartTagCompleteHash(0,[])')})
"au Filetype * call timer_start(100, {-> execute('call SmartTagCompleteHash(0,[])')})

" 有lsp插件暂不使用
fu! SmartTagCompleteHash(findstart, base) abort
  if !exists('b:tag_index')
    let b:tag_index = {}

    " 构建 tags 哈希表
    for tagfile in split(&tags, ',')
      if empty(tagfile) || !filereadable(tagfile)
        continue
      endif
      for line in readfile(tagfile)
        let word = matchstr(line, '^\S\+')
        if empty(word)
          continue
        endif
        let key = strpart(word, 0, 1)
        if !has_key(b:tag_index, key)
          let b:tag_index[key] = []
        endif
        call add(b:tag_index[key], word)
      endfor
    endfor
  endif

  " === 找补全起点 ===
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\k'
      let start -= 1
    endwhile
    return start
  else
    " === 查找补全内容 ===
    let colpos = col('.') - 1
    if colpos == 0
      return []
    endif
    let line = getline('.')
    let prefix = matchstr(line[0:colpos-1], '\k*$')
    if len(prefix) < 1
      return []
    endif

    " 合并语法补全 + tag 哈希补全
    let completions = syntaxcomplete#Complete(0, a:base)
    let key = strpart(prefix, 0, 1)
    if has_key(b:tag_index, key)
      for word in b:tag_index[key]
        if word[:len(prefix)-1] == prefix
          call add(completions, word)
        endif
      endfor
    endif

    return uniq(sort(completions))
  endif
endf

"inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

