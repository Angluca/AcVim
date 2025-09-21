" PRELUDE {{{1
" Vim syntax file

if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'litac'

syn keyword PreProc or and not
syn match PreProc        '[@]'
syn match litacSymbol     '[,;]'
syn match Operator       '[\+\-\%=\/\^\&\*!?><\$|]'
syn match SpecialComment '[`:\.]'
syn match Constant       '[{}\[\]()]'
hi def litacSymbol ctermfg=DarkGray guifg=DarkGray

hi def link litacFunc Function
hi def link litacTypedef Identifier
hi def litacType ctermfg=DarkCyan guifg=DarkCyan
hi def litacThis ctermfg=DarkMagenta guifg=DarkMagenta
"syn match litacAttribute '\(^\s*\[\s*\)\@<=\w\w*\ze\s*.\{-}\]'
"syn match litacType '\(\s*<\s*\)\@<=\w\w*\ze\s*.\{-}>'
syn match Repeat   "\([^\.]\.\)\@<=\w\w*\(\(\[.\{-}\]\)*\s*(\)\@!"
syn match litacFloat "\([0-9]\+\.\)\@<=[0-9][0-9]*\(f32\|f64\)*"
syn match litacThis '\(\w\)\@<!this\(\w\)\@!'
syn match litacType    "\w\(\w\)*\ze\(<.\{-}>\s*\)*::[^<]"
"syn match litacType '\(\(\(\W\|^\)\(let\|const\|def\)\s\+[^=]\{-}\s*)*\s*:\s*\W\{-}\)\|\(^\W\{-}\w\w*\s*:\s*\W\{-}\)\)\@<=\w\+\(.\{-},\s*$\)\@!'
syn match litacFunc   "[0-9a-zA-Z_@]\w*\(\(<.\{-}>\s*\)*\(\[.\{-}\]\)*\s*(\)\@="


" SYNTAX {{{1
syn case match

" KEYWORDS {{{2
syn keyword litacCast as is
syn keyword litacConditional if then else match switch
syn keyword litacKeyword break continue defer return yield
syn keyword litacKeyword const def let var fn func trait
"syn keyword litacKeyword fn
syn keyword litacLabel case
syn keyword litacRepeat for while in
"syn keyword litacStorageClass export static
syn keyword litacStructure enum struct union namespace typedef
"syn keyword litacTypedef type

" Attributes
syn keyword litacAttribute extern exits invalid public import
syn match litacAttribute '@\w\+'
"syn match litacAttributeError '^\[\w\+\]'

" BUILTINS {{{2
syn keyword litacBuiltin abort assert
syn keyword litacBuiltin align offset
syn keyword litacBuiltin alloc calloc malloc
syn keyword litacBuiltin append insert delete

" C compiler
syn keyword Repeat c_include c_flag c_embed

" TYPES {{{2
syn keyword litacType bool
syn keyword litacType f32 f64
syn keyword litacType i8 i16 i32 i64 u8 u16 u32 u64 char
syn keyword litacType int uint untyped_ptr
syn keyword litacType str
syn keyword litacType void

" `size` can either be a builtin or a type. Match it as a type by default,
" unless the next non-comment token is an open paren, in which case prioritize
" matching it as a builtin.
"syn match litacType '\v<size>' display
"syn match litacBuiltin '\v<size>\ze(\s*|//.*\_$)*\(' display

" LITERALS {{{2
syn keyword litacBoolean true false
syn keyword litacNull null

" Floating-point number literals
"syn match litacFloat '\v<(0|[1-9]\d*)\.\d+([eE][+-]?\d+)?(f32|f64)?>' display

syn match litacFloat '\v<\.?\d+([eE][+-]?\d+)?(f32|f64)?>' display
syn match litacFloat '\v<(0|[1-9]\d*)([eE][+-]?\d+)?(f32|f64)>' display
syn match litacFloat '\v<0x\x+(\.\x+)?[pP][+-]?\d+(f32|f64)?>' display

" Integer literals
syn match litacInteger '\v(\.@1<!|\.\.)\zs<(0|[1-9]\d*)([eE][+-]?\d+)?([iu](8|16|32|64)?|z)?>' display
syn match litacInteger '\v(\.@1<!|\.\.)\zs<0b[01]+([iu](8|16|32|64)?|z)?>' display
syn match litacInteger '\v(\.@1<!|\.\.)\zs<0o\o+([iu](8|16|32|64)?|z)?>' display
syn match litacInteger '\v(\.@1<!|\.\.)\zs<0x\x+([iu](8|16|32|64)?|z)?>' display

" Escape sequences
syn match litacEscape '\\[\\'"0abfnrtv]' contained display
syn match litacEscape '\v\\(x\x{2}|u\x{4}|U\x{8})' contained display

" Format sequences
syn match litacFormat '\v\{\d*(\%\d*|:([- +=befgoxX]|F[.2sESU]|\.?\d+|_(.|\\([\\'"0abfnrtv]|x\x{2}|u\x{4}|\x{8})))*)?}' contained contains=litacEscape display
syn match litacFormat '{{\|}}' contained display

" Rune and string literals
syn region litacString start='`' end='`\|$' skip="\\'" contains=litacEscape,litacFormat display
syn region litacString start='"' end='"\|$' skip='\\"' contains=litacEscape,litacFormat display
syn region litacString start='"""' end='"""' contains=litacFormat display

" MISCELLANEOUS {{{2
syn keyword litacTodo FIXME TODO XXX contained

" Blocks
syn region litacBlock start='{' end='}' fold transparent

" Comments
syn region litacComment start='//' end='$' contains=litacCommentDoc,litacTodo,@Spell display
syn region litacComment start='/\*' end='\*/' contains=litacCommentDoc,litacTodo,@Spell display
syn match litacCommentRef '\v\[\[\h\w*(::\h\w*)*(::)?]]' contained display

" Match `!` as an error assertion operator only if the previous non-comment
" token is a closing paren, `!` or `?`, or a valid identifier followed by an
" optional tuple field access. Do not include `!=` in the matches.
syn match litacErrorAssertion '\v((\h\w*(\.\d+)*|[!?]|\))(\s*|//.*\_$)*)@<=!\=@!' display
"syn match litacErrorPropagation '?' display

" Incorrect whitespace
syn match litacSpaceError '\v\s+$' display
syn match litacSpaceError '\v\zs +\ze\t' display

" Import statement
syn region litacImport start='\v^\s*\zsimport>' end='$' contains=litacComment display
syn region litacImport start='\v^\s*\zsimport .*\{' end='\}' contains=litacComment display
syn region litacImport start='\v^\s*\zs#\w*>' end='$' contains=litacComment display

" DEFAULT HIGHLIGHTING {{{1
hi def link litacAttribute PreProc
hi def link litacBoolean Boolean
hi def link litacBuiltin Function
hi def link litacCast Operator
hi def link litacComment Comment
hi def link litacCommentRef SpecialComment
hi def link litacConditional Conditional
hi def link litacEscape SpecialChar
hi def link litacFloat Number
hi def link litacFormat SpecialChar
hi def link litacInteger Number
hi def link litacKeyword Keyword
hi def link litacLabel Label
hi def link litacNull Constant
hi def link litacRepeat Repeat
hi def link litacRune Character
hi def link litacStorageClass StorageClass
hi def link litacString String
hi def link litacStructure Structure
hi def link litacTodo Todo
"hi def link litacType Type
"hi def link litacTypedef Typedef
hi def link litacImport Include

" Default highlighting for error propagation operators
hi def litacErrorAssertion ctermfg=red cterm=bold guifg=red gui=bold
hi def litacErrorPropagation ctermfg=red cterm=bold guifg=red gui=bold

" Highlight invalid attributes.
hi def link litacAttributeError Error

syn match litacTypedef  contains=litacTypedef "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match litacFunc    "\%(r#\)\=\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
"syn keyword Keyword   def nextgroup=Function skipwhite skipempty
syn keyword litacKeyword union struct enum namespace typedef nextgroup=litacTypedef skipwhite skipempty
syn keyword litacKeyword union nextgroup=litacType skipwhite skipempty contained

" vim: et sw=2 sts=2 ts=8
