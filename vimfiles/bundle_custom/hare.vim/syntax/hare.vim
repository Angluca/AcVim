" PRELUDE {{{1
" Vim syntax file
" Language:    Hare
" Maintainer:  Amelia Clarke <selene@perilune.dev>
" Last Change: 2024-01-02
" Upstream:    https://git.sr.ht/~sircmpwn/hare.vim

if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'hare'

" SYNTAX {{{1
syn case match

" KEYWORDS {{{2
syn keyword hareCast as is
syn keyword hareConditional if else match switch
syn keyword hareKeyword break continue defer return yield
syn keyword hareKeyword const def let
syn keyword hareKeyword fn
syn keyword hareLabel case
syn keyword hareRepeat for
syn keyword hareStorageClass export static
syn keyword hareStructure enum struct union
syn keyword hareTypedef type

" Attributes
syn keyword hareAttribute @init @fini @test
syn keyword hareAttribute @offset @packed
syn keyword hareAttribute @symbol
syn keyword hareAttribute @threadlocal
syn match hareAttributeError '@\w\+'

" BUILTINS {{{2
syn keyword hareBuiltin abort assert
syn keyword hareBuiltin align len offset
syn keyword hareBuiltin alloc free
syn keyword hareBuiltin append insert delete

" C ABI
syn keyword hareBuiltin vastart vaarg vaend

" TYPES {{{2
syn keyword hareType bool
syn keyword hareType f32 f64
syn keyword hareType i8 i16 i32 i64 u8 u16 u32 u64
syn keyword hareType int uint uintptr
syn keyword hareType never
syn keyword hareType nullable
syn keyword hareType opaque
syn keyword hareType rune str
syn keyword hareType void

" C ABI
syn keyword hareType valist

" `size` can either be a builtin or a type. Match it as a type by default,
" unless the next non-comment token is an open paren, in which case prioritize
" matching it as a builtin.
syn match hareType '\v<size>' display
syn match hareBuiltin '\v<size>\ze(\_s*|//.*\_$)*\(' display

" LITERALS {{{2
syn keyword hareBoolean true false
syn keyword hareNull null

" Floating-point number literals
syn match hareFloat '\v<(0|[1-9]\d*)\.\d+([eE][+-]?\d+)?(f32|f64)?>' display
syn match hareFloat '\v<(0|[1-9]\d*)([eE][+-]?\d+)?(f32|f64)>' display
syn match hareFloat '\v<0x\x+(\.\x+)?[pP][+-]?\d+(f32|f64)?>' display

" Integer literals
syn match hareInteger '\v(\.@1<!|\.\.)\zs<(0|[1-9]\d*)([eE][+-]?\d+)?([iu](8|16|32|64)?|z)?>' display
syn match hareInteger '\v(\.@1<!|\.\.)\zs<0b[01]+([iu](8|16|32|64)?|z)?>' display
syn match hareInteger '\v(\.@1<!|\.\.)\zs<0o\o+([iu](8|16|32|64)?|z)?>' display
syn match hareInteger '\v(\.@1<!|\.\.)\zs<0x\x+([iu](8|16|32|64)?|z)?>' display

" Escape sequences
syn match hareEscape '\\[\\'"0abfnrtv]' contained display
syn match hareEscape '\v\\(x\x{2}|u\x{4}|U\x{8})' contained display

" Format sequences
syn match hareFormat '\v\{\d*(\%\d*|:([- +=befgoxX]|F[.2sESU]|\.?\d+|_(.|\\([\\'"0abfnrtv]|x\x{2}|u\x{4}|\x{8})))*)?}' contained contains=hareEscape display
syn match hareFormat '{{\|}}' contained display

" Rune and string literals
syn region hareRune start="'" end="'\|$" skip="\\'" contains=hareEscape display
syn region hareString start='"' end='"\|$' skip='\\"' contains=hareEscape,hareFormat display
syn region hareString start='`' end='`' contains=hareFormat display

" MISCELLANEOUS {{{2
syn keyword hareTodo FIXME TODO XXX contained

" Blocks
syn region hareBlock start='{' end='}' fold transparent

" Comments
syn region hareComment start='//' end='$' contains=hareCommentDoc,hareTodo,@Spell display
syn match hareCommentRef '\v\[\[\h\w*(::\h\w*)*(::)?]]' contained display

" Match `!` as an error assertion operator only if the previous non-comment
" token is a closing paren, `!` or `?`, or a valid identifier followed by an
" optional tuple field access. Do not include `!=` in the matches.
syn match hareErrorAssertion '\v((\h\w*(\.\d+)*|[!?]|\))(\_s*|//.*\_$)*)@<=!\=@!' display
syn match hareErrorPropagation '?' display

" Incorrect whitespace
syn match hareSpaceError '\v\s+$' display
syn match hareSpaceError '\v\zs +\ze\t' display

" Use statement
syn region hareUse start='\v^\s*\zsuse>' end=';' contains=hareComment display

" DEFAULT HIGHLIGHTING {{{1
hi def link hareAttribute PreProc
hi def link hareBoolean Boolean
hi def link hareBuiltin Function
hi def link hareCast Operator
hi def link hareComment Comment
hi def link hareCommentRef SpecialComment
hi def link hareConditional Conditional
hi def link hareEscape SpecialChar
hi def link hareFloat Float
hi def link hareFormat SpecialChar
hi def link hareInteger Number
hi def link hareKeyword Keyword
hi def link hareLabel Label
hi def link hareNull Constant
hi def link hareRepeat Repeat
hi def link hareRune Character
hi def link hareStorageClass StorageClass
hi def link hareString String
hi def link hareStructure Structure
hi def link hareTodo Todo
hi def link hareType Type
hi def link hareTypedef Typedef
hi def link hareUse Include

" Default highlighting for error propagation operators
hi def hareErrorAssertion ctermfg=red cterm=bold guifg=red gui=bold
hi def hareErrorPropagation ctermfg=red cterm=bold guifg=red gui=bold

" Highlight invalid attributes.
hi def link hareAttributeError Error

" vim: et sw=2 sts=2 ts=8
