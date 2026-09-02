vim9script
#=================================
# Plugin configuration
#=================================
# -- ShowMarks ------
g:showmarks_include = 'abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ'
g:showmarks_ignore_type = 'hmpq'
# -- qbuf ------
g:qb_hotkey = ';bb'
# -- Tagbar (similar taglist) ------
#g:tagbar_ctags_bin = 'ctags'
g:tagbar_autoclose = 1
g:tagbar_width = 28
g:tagbar_autofocus = 1
g:tagbar_compact = 1
#g:tagbar_sort = 0
#g:tagbar_expand = 0
#g:tagbar_singleclick = 1
#g:tagbar_foldlevel = 2
#g:tagbar_systemenc = 'gbk'
#g:tagbar_updateonsave_maxlines = 10000

g:tagbar_type_mach = {
    ctagstype: 'mach',
    kinds: ['m:mod:0:1', 'r:rec:0:1', 'u:uni:0:1', 'f:fun:0:1', 't:test:1:0', 'v:var:1:0'],
    deffile: expand('<sfile>:p:h:h') .. '/dict/mach.local.ctags',
}

g:tagbar_type_spectre = {
    ctagstype: 'spectre',
    kinds: ['t:type:0:1', 'e:enum:0:1', 'u:union:0:1', 'f:fn:0:1', 'v:var:1:0'],
    deffile: expand('<sfile>:p:h:h') .. '/dict/spectre.local.ctags',
}

g:tagbar_type_ocen = {
    ctagstype: 'ocen',
    kinds: ['f:func:0:1', 't:type:1:0'],
    deffile: expand('<sfile>:p:h:h') .. '/dict/ocen.ctags',
}

g:tagbar_type_dither = {
    ctagstype: 'dither',
    kinds: ['f:func:0:1', 'v:var:0:1', 't:type:1:0'],
    deffile: expand('<sfile>:p:h:h') .. '/dict/dither.ctags',
}

g:tagbar_type_nature = {
    ctagstype: 'nature',
    kinds: ['f:func:0:1', 'v:var:1:0', 't:type:0:1', 'm:mod:1:0'],
    deffile: expand('<sfile>:p:h:h') .. '/dict/nature.ctags',
}

g:tagbar_type_virgil = {
    ctagstype: 'virgil',
    kinds: [
        'c:component:0:1',
        'l:layout:0:1',
        's:class:0:1',
        'm:macro:0:1',
        't:type:0:1',
        'e:enum:0:1',
        'f:func:0:1',
        'a:case:1:0',
        'v:var:1:0',
        'n:enums:1:0',
    ],
    sro: '::',
    kind2scope: { c: 'component', l: 'layout', s: 'class', m: 'macro', t: 'type', e: 'enum' },
    scope2kind: { component: 'c', layout: 'l', class: 's', macro: 'm', type: 't', enum: 'e' },
    deffile: expand('<sfile>:p:h:h') .. '/dict/virgil.ctags',
}

nmap <silent> ;tl :TagbarToggle<cr>
# -- NERDTree ------
#g:NERDTreeMinimalUI = 1
#g:NERDTreeMinimalMenu = 1
g:NERDTreeQuitOnOpen = 1
g:NERDChristmasTree = 0
g:NERDTreeAutoCenter = 1
g:NERDTreeMouseMode = 1
g:NERDTreeShowFiles = 1
g:NERDTreeShowHidden = 0
g:NERDTreeShowLineNumbers = 0
#g:NERDTreeWinPos = 'left'
g:NERDTreeWinSize = 30
g:NERDTreeIgnore = ['\.o$', '\~$', '\.a$', '\.bak$', '\.d$', '\.ncb$', '\.bmp$',
    '\.exe$', '\.tar\.gz$', '\.7z$', '\.zip$', '\.rar$', '\.swp$', '\.dll$', '\.obj$']
nmap <silent> ;tt :NERDTreeToggle <cr>
# -- NERD_commenter ------
#g:NERDCustomDelimiters = { vim: { left: '#' } }
g:NERDCreateDefaultMappings = 0
if has('gui_running')
    g:AcSetMap('<plug>NERDCommenterToggle', '<d-/>')
else
    g:AcSetMap('<plug>NERDCommenterToggle', '<m-/>')
endif
g:AcSetMap('<plug>NERDCommenterComment', ';xx')
g:AcSetMap('<plug>NERDCommenterMinimal', ';xm')
g:AcSetMap('<plug>NERDCommenterSexy', ';xs')
g:AcSetMap('<plug>NERDCommenterInvert', ';xi')
g:AcSetMap('<plug>NERDCommenterYank', ';xy')
g:AcSetMap('<plug>NERDCommenterAlignLeft', ';xl')
g:AcSetMap('<plug>NERDCommenterAlignBoth', ';xb')
g:AcSetMap('<plug>NERDCommenterNest', ';xn')
g:AcSetMap('<plug>NERDCommenterUncomment', ';xu')
g:AcSetMap('<plug>NERDCommenterToEOL', ';xe')
g:AcSetMap('<plug>NERDCommenterAltDelims', ';xd')
g:AcSetMap('<plug>NERDCommenterAppend', ';xa')
# -- easymotion ------
##let EasyMotion_do_mapping = 0
##let g:EasyMotion_keys = 'vcxzbtrewqyuiopnmhgasdfjkl;'
#let g:EasyMotion_keys = 'fjdksla;rueiwoqpvncmxhzygbt'
#let g:EasyMotion_leader_key = 'gw'
#let g:EasyMotion_startofline = 0
#let g:EasyMotion_do_shade = 0
#let g:EasyMotion_smartcase = 1
##let g:EasyMotion_grouping = 1
##let g:EasyMotion_use_upper = 1
#let g:EasyMotion_enter_jump_first = 1
##let g:EasyMotion_use_regexp = 1
##let g:EasyMotion_space_jump_first = 0
##let g:EasyMotion_disable_two_key_combo = 0
##let g:EasyMotion_off_screen_search = 0
#map f <Plug>(easymotion-jumptoanywhere)
#nmap f <Plug>(easymotion-overwin-f)
#nmap F <Plug>(easymotion-overwin-f2)
#map T <Plug>(easymotion-bd-jk)
#nmap T <Plug>(easymotion-overwin-line)
# -- EasyAlign ------
#vnoremap <silent> <Enter> :EasyAlign<cr>
#nmap <space><enter> <Plug>(EasyAlign)
xmap <Enter> <Plug>(EasyAlign)
# -- vim-markdown ------
g:vim_markdown_fenced_languages = ['bash=sh', 'viml=vim', 'nims=nim', 'ini=dosini']
g:vim_markdown_folding_disabled = 1
g:vim_markdown_no_default_key_mappings = 1
g:vim_markdown_conceal_code_blocks = 0
g:vim_markdown_conceal = 0
g:vim_markdown_override_foldtext = 0
g:tex_conceal = ''
g:vim_markdown_auto_insert_bullets = 0
#g:vim_markdown_auto_extension_ext = 'txt'
#g:vim_markdown_math = 1
#g:vim_markdown_toc_autofit = 0
#g:vim_markdown_folding_style_pythonic = 1
#g:vim_markdown_initial_foldlevel = 3
# -- lightline ------
set laststatus=2
g:lightline = { colorscheme: 'jellybeans' }
# -- undotree ------
#g:undotree_RelativeTimestamp = 0
g:undotree_SetFocusWhenToggle = 1
g:undotree_WindowLayout = 3
nmap ;ut :UndotreeToggle<cr>
# -- auto-pairs ------
#g:AutoPairsCompatibleMaps = 1
#let g:AutoPairsLanguagePairs = {
#    vim: {'\v^\s*\zs"': ''},
#    rust: {'\w\zs<': '>', '&\zs''': ''},
#    php: {'<?': '?>//k]', '<?php': '?>//k]'},
#    nim: {'{\.': '\.}', '`': '`'},
#    zig: {'|': '|'},
#    ocen: {'`': {closer: '`'}},
#}
#g:pear_tree_pairs = {
#    '(': {closer: ')'},
#    '[': {closer: ']'},
#    '{': {closer: '}'},
#    "'": {closer: "'"},
#    '"': {closer: '"'},
#    '`': {closer: '`'},
#}
#g:pear_tree_map_special_keys = 0
#g:pear_tree_repeatable_expand = 0
#g:pear_tree_smart_openers = 0
#g:pear_tree_smart_closers = 0
#g:pear_tree_smart_backspace = 0
#imap <BS> <Plug>(PearTreeBackspace)
#imap <CR> <Plug>(PearTreeExpand)
#imap <Esc> <Plug>(PearTreeFinishExpansion)
#imap <M-n> <Plug>(PearTreeJump)
#imap <M-i> <Plug>(PearTreeExpandOne)
#imap <M-o> <Plug>(PearTreeJNR)
#imap <M-space> <Plug>(PearTreeSpace)
# -- building ------
com! -bang -nargs=* -range=% -complete=shellcmd AcSend FloatermSend<bang> <args>
com! -bang -nargs=* -range=% -complete=shellcmd AcRun FloatermNew<bang> --disposable --autoclose=never --height=0.5 --width=0.98 <args>
#nmap <space>r :AcSend
nmap <space>r :AcRun
nmap <space>R :AcRun!
#------------------------------------------
g:AcFtCmd('*', 'Make', 'Makefile', 'AcRun make <args>')
#------------------------------------------
#g:AcFtCmd('c,cpp', 'H', 'cex.h', 'AcRun ./cex help <args>')
#g:AcFtCmd('c,cpp', 'E', 'cex.h', 'AcRun ./cex <args>')
#g:AcFtCmd('c,cpp', 'T', 'cex.h', 'AcRun ./cex test <args>')
#g:AcFtCmd('c,cpp', 'F', 'cex.h', 'AcRun ./cex fuzz <args>')
#g:AcFtCmd('c,cpp', 'G', 'cex.h', 'AcRun ./cex libfetch <args>')
#g:AcFtCmd('c,cpp', 'C', 'cex.h', 'AcRun ./cex app <args>')
#g:AcFtCmd('c,cpp', 'CEXc', 'cex.h', '!cc ./cex.c -o cex')
#g:AcFtCmd('c,cpp', 'CEXh', 'cex.h', '!cc -D CEX_NEW -x c ./cex.h -o cex && ./cex')
au filetype c,cpp com! -bang -nargs=* -complete=file Run AcRun make -r <args>
au filetype c,cpp com! -bang -nargs=* -complete=file CC AcRun gcc <args> %:p -o %:t:r
au filetype c,cpp com! -bang -nargs=* -complete=file RR AcRun gcc <args> %:p -r -o %:t:r
au filetype nim com! -bang -nargs=* -complete=file T AcRun nim r <args> %
au filetype nim com! -bang -nargs=* -complete=file C AcRun nim <args> %
au filetype nim com! -bang -nargs=* -complete=file NN AcRun nimble <args>
au filetype zig com! -bang -nargs=* -complete=file CC AcRun zig <args> %
au filetype zig com! -bang -nargs=* -complete=file C AcRun zig <args>
au filetype d com! -bang -nargs=* -complete=file C AcRun dmd <args> %
au filetype d com! -bang -nargs=* -complete=file D AcRun dub <args>
au filetype hare com! -bang -nargs=* -complete=file C AcRun hare <args> %
g:AcFtCmd('ocen', 'C', '', 'AcRun ocen % -o %:t:r <args>')
g:AcFtCmd('ocen', 'R', '', 'AcRun ocen % -o %:p:r <args> -r')
g:AcFtCmd('ocen', 'XX', '', 'AcRun trash %:t:r %:t:r.c')
#let $RUST_BACKTRACE = 'full'
$MAKEPAD = 'lines'
#--nocapture 测试里显示打印
#--show-output 测试里显示更多内容
g:AcFtCmd('rust', 'RE', 'Cargo.toml', 'AcRun cargo run --example=%:t:r <args> --release')
g:AcFtCmd('rust', 'RD', 'Cargo.toml', 'AcRun cargo run <args>')
g:AcFtCmd('rust', 'R', 'Cargo.toml', 'AcRun cargo run <args> --release')
g:AcFtCmd('rust', 'T', 'Cargo.toml', 'AcRun cargo test <args>')
g:AcFtCmd('rust', 'BD', 'Cargo.toml', 'AcRun cargo build <args>')
g:AcFtCmd('rust', 'B', 'Cargo.toml', 'AcRun cargo build <args> --release')
g:AcFtCmd('rust', 'E', 'Cargo.toml', 'AcRun cargo check <args>')
g:AcFtCmd('rust', 'C', 'Cargo.toml', 'AcRun cargo <args>')
g:AcFtCmd('rust', 'XX', 'Cargo.toml', 'AcRun cargo clean <args>')
g:AcFtCmd('rust', 'TT', 'Cargo.toml', 'AcRun cargo test <args> -- --nocapture')
au filetype rust com! -bang -nargs=* -complete=file XT AcRun trash %:t:r
au filetype rust com! -bang -nargs=* -complete=file RT exe 'AcRun! rustc <args> % && ./%:t:r' | exe 'AcSend exit'
g:AcFtCmd('spectre', 'Init', '', 'AcRun spectre init <args>')
g:AcFtCmd('spectre,modsim3', 'B', 'sx.mod', 'AcRun spectre build release <args>')
g:AcFtCmd('spectre,modsim3', 'BB', 'sx.mod', 'AcRun spectre build <args>')
g:AcFtCmd('spectre', 'C', '', 'AcRun spectre % <args> --release')
g:AcFtCmd('spectre', 'CC', '', 'AcRun spectre % <args> --show-cmd')
g:AcFtCmd('spectre', 'T', '', 'AcRun spectre % <args> --test')
g:AcFtCmd('spectre', 'TT', '', 'AcRun spectre % <args> --test --show-cmd')
g:AcFtCmd('spectre', 'R', '', 'AcRun spectre run % <args> --release')
g:AcFtCmd('spectre', 'RR', '', 'AcRun spectre run % <args> --show-cmd')
g:AcFtCmd('mach', 'M', 'mach.toml', 'AcRun make %:t:r <args>')
g:AcFtCmd('mach', 'MM', 'mach.toml', 'AcRun make run %:t:r <args>')
g:AcFtCmd('mach', 'R', 'mach.toml', 'AcRun mach run . -v <args>')
g:AcFtCmd('mach', 'RR', 'mach.toml', 'AcRun mach run . <args> -v --profile release')
g:AcFtCmd('mach', 'B', 'mach.toml', 'AcRun mach build . -v <args>')
g:AcFtCmd('mach', 'BB', 'mach.toml', 'AcRun mach build . -v <args> --profile release')
g:AcFtCmd('mach', 'T', 'mach.toml', 'AcRun mach test . -vv <args>')
g:AcFtCmd('mach', 'TT', 'mach.toml', 'AcRun mach test . -vv <args> --profile release')
g:AcFtCmd('mach', 'XX', 'mach.toml', 'AcRun mach clean .')
# -- floaterm ------
g:floaterm_width = 0.98
g:floaterm_height = 0.9
g:floaterm_autoclose = 0
g:floaterm_position = 'bottom'
g:floaterm_keymap_toggle = '<m-s-space>'
g:floaterm_keymap_kill = '<m-Q>'
#g:floaterm_keymap_new = '<m-N>'
#g:floaterm_keymap_prev = '<m-k>'
#g:floaterm_keymap_next = '<m-j>'
#g:floaterm_keymap_first = '<m-h>'
#g:floaterm_keymap_last = '<m-l>'
tnoremap <silent> <esc> <C-\><C-n>
nnoremap <silent> <m-O> :FloatermNew --disposable<CR>
tnoremap <silent> <m-O> <C-\><C-n>:FloatermNew --disposable<CR>
tnoremap <silent> <m-P> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <m-N> <C-\><C-n>:FloatermNext<CR>
#tnoremap <silent> <m-h> <C-\><C-n>:FloatermFirst<CR>
#tnoremap <silent> <m-l> <C-\><C-n>:FloatermLast<CR>
# -- vsnip ------
g:vsnip_snippet_dir = $VIM .. 'snippets/'
#imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
#smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<M-n>'
smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<M-n>'
smap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<M-p>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
# -- lsp ------
#set keywordprg=:LspHover
nmap <buffer> ;tL <Cmd>LspOutline<cr>
#nmap <buffer> K <Cmd>LspHover<cr>
nmap <silent> <space>k <Cmd>LspHover<cr>
#nmap <c-]> <Cmd>LspGotoDefinition<CR>
#nmap <c-s-]> <Cmd>topleft LspGotoDefinition<CR>
#nmap ge <Cmd>LspGotoDefinition<CR>
nmap gs <cmd>call g:GotoRead('LspGotoDefinition')<CR>
#nmap ga <Cmd>LspGotoDeclaration<CR>
nmap gS <cmd>call g:GotoRead('LspGotoDeclaration')<CR>
#nmap ge <Cmd>LspPeekDeclaration<CR>
#nmap gE <Cmd>LspPeekDefinition<CR>
#nmap <C-W>gd <Cmd>topleft LspGotoDefinition<CR>
#nmap gi <Cmd>LspGotoImpl<CR>
nmap gi <cmd>call g:GotoRead('LspGotoImpl')<CR>
#nmap gt <Cmd>LspGotoTypeDef<CR>
nmap gy <cmd>call g:GotoRead('LspGotoTypeDef')<CR>
#nmap gi <Cmd>LspPeekImpl<CR>
#nmap gt <Cmd>LspPeekTypeDef<CR>
nmap g[ <Cmd>g:LspDiagPrev<CR>
nmap g] <Cmd>g:LspDiagNext<CR>
#nmap gs <Cmd>LspSymbolSearch<CR>
#nmap gS <Cmd>LspDocumentSymbol<CR>
#nmap gr <Cmd>LspPeekReferences<CR>
nmap gr <Cmd>g:LspShowReferences<CR>
nmap g\ <Cmd>g:LspServer restart<CR>

#au filetype rust vim9cmd g:LspAddServer([{ name: 'rust-analyzer', filetype: ['rust'], path: exepath('rust-analyzer'), syncInit: true }])
setl omnifunc=g:LspOmniFunc
g:lsp_options = {
    outlineOnRight: true,
    outlineWinSize: 30,
    autoHighlightDiags: false,
    showDiagInBalloon: false,
    aleSupport: false,
    autoComplete: false,
    snippetSupport: false,
    vsnipSupport: true,
    bufferCompletionTimeout: 66,
    filterCompletionDuplicates: true,
    completionMatcher: 'fuzzy',
    showSignature: true,
}
au User g:LspSetup <cmd>call g:LspOptionsSet(g:lsp_options)
g:lsp_servers = [
    { name: 'clangd',  filetype: ['c', 'cpp'], path: exepath('clangd'),  args: ['--background-index'] },
    { name: 'mach',    filetype: ['mach'],     path: exepath('mls') },
    { name: 'spectre', filetype: ['spectre'],  path: exepath('spectre-ls') },
    { name: 'ocen',    filetype: ['ocen'],     path: exepath('ocen'),    args: ['lsp-server'] },
    { name: 'nimlsp',  filetype: ['nim'],      path: exepath('nimlsp') },
    { name: 'zls',     filetype: ['zig'],      path: exepath('zls') },
    { name: 'serve-d', filetype: ['d'],        path: exepath('serve-d') },
    # { name: 'rust-analyzer', filetype: ['rust'], path: exepath('rust-analyzer'), syncInit: true },
]
au User g:LspSetup <cmd>call g:LspAddServer(g:lsp_servers)
# -- another ------

defcompile
