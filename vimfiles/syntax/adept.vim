if exists("b:current_syntax")
    finish
endif

syntax keyword adeptKeyword POD alias and as at break case cast continue def default defer delete
syntax keyword adeptKeyword each else enum external fallthrough for foreign func funcptr global extends
syntax keyword adeptKeyword if import in inout new or out packed private public repeat return
syntax keyword adeptKeyword sizeof static stdcall struct switch typeinfo unless until while
syntax keyword adeptKeyword va_start va_end va_copy va_arg verbatim void union exhaustive
syntax keyword adeptKeyword const define namespace using implicit pragma elif llvm_asm embed assert
syntax keyword adeptKeyword typenameof alignof record constructor class virtual override
highlight link adeptKeyword Keyword

syntax keyword adeptCommonType bool byte ubyte short ushort int uint long ulong usize successful
syntax keyword adeptCommonType float double ptr String List Array VariadicArray InitializerList
syntax keyword adeptCommonType Vector2f Vector3f Matrix4f AABB TypeInfo FILE va_list
highlight link adeptCommonType adeptType

syntax keyword adeptCommonName true false null undef it idx
highlight link adeptCommonName Boolean

syn match PreProc        '[@]'
syn match adeptSymbol    '[,;]'
syn match Operator       '[\+\-\%=\/\^\&\*!?><\$|~#]'
syn match SpecialComment '[`:\.]'
syn match Constant       '[{}\[\]()]'
hi def adeptSymbol ctermfg=DarkGray guifg=DarkGray

hi def link adeptFunc Function
hi def adeptType ctermfg=DarkCyan guifg=DarkCyan
hi def adeptThis ctermfg=DarkMagenta guifg=DarkMagenta
"syn match adeptType     '\(\**\w\w*\s\+\(\(<.*>\)\|\(\[.*\]\)\)*\s*\**\)\@<=\w\w*\s*'
"syn match void     '\(\w\w*\s\+\**\)\@<=\w\w*\s*\ze\(\([a-zA-Z0-9\._]\)\|\(<.*>\)\|\(\[.*\]\)\)*\s*\({\)'
"syn match adeptType     "\()\s*\(\(<.*>\)\|\(\[.*\]\)\)*\**\s*\)\@<=\w\w*\s*\ze{*\s*$"
"syn match adeptType     "\(\([$#~]\+\w*[$#~]*\)\)\@<=\w\w*\s*"
"syn match SpecialComment '\s*\(\w\)\@<!__[0-9a-zA-Z]\w*[0-9a-zA-Z]__\(\w\)\@!\s*'
"syn match SpecialComment '\(^import\s\+\)\@<=\(\w\w*\)'
"syn match adeptType     '\(<.*\)\@<=\w\w*\(>\)\@='
"syn match void          '\(\[*\)\@<=\w\w*\(\[*.*\]\)\@='

syn match adeptThis     '\(\w\)\@<!this\(\w\)\@!'
syn match adeptType     "\w\(\w\)*\s*\ze\(<.*>\s*\)*\(:\{1,2}\|\\\)[^:\\]"
syn match Repeat        "\([^\.\\:]\(\.\|\\\|:\{1,2}\)\)\@<=\w\w*"
syn match adeptFunc     "\w\w*\s*\ze\(\[.*\]\)*\s*("

syn match adeptTypedef contains=adeptTypedef "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match adeptFunc    "\%(r#\)\=\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn keyword adeptKeyword union class struct enum namespace typedef extends nextgroup=adeptTypedef skipwhite skipempty
syn keyword adeptKeyword union nextgroup=adeptType skipwhite skipempty contained
hi def link adeptTypedef Identifier

highlight link adeptPreprocessor Preproc
syn match adeptPreprocessor   "#\w[0-9a-zA-Z_]*"
syn match SpecialComment    "\(#\w[0-9a-zA-Z_ !]*\)\@<=\(\w\w*\)"

syntax match adeptNumber "\v<((0x[0-9A-Fa-f]+)|(([0-9]+(\.[0-9]+)?)(e-?[0-9]*)?))(u|s|ub|sb|us|ss|ui|si|ul|sl|uz|f|d)?>"
highlight link adeptNumber Number

syntax region adeptString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region adeptString start=/\v'/ skip=/\v\\./ end=/\v'(ub)?/
highlight link adeptString String

syntax match adeptLineComment "\v//.*$"
highlight link adeptLineComment Comment

syntax region adeptBlockComment start=/\V\/*/ end=/\V*\//
highlight link adeptBlockComment Comment

let b:current_syntax = "adept"
