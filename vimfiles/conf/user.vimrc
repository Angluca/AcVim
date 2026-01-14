"=================================
" Plugin configuration
"=================================
""""""""""""""""""""
"ShowMarks {{{
""""""""""""""""""""
let showmarks_include = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_ignore_type = "hmpq"    "help,non-modify,preview,quick-fix buffer do not display
"<leader>mt ShowMarksToggle
"<leader>mo ShowmarksShowMarksOn
"<leader>mc ShowmarksClearMark
"<leader>ma ShowmarksClearAll
"<leader>mm ShowmarksPlaceMark
"}}}
""""""""""""""""""""
"errormarker {{{
""""""""""""""""""""
let errormarker_disablemappings = 1
nmap <silent> ,ee :ErrorAtCursor<CR>
nmap <silent> ,er :ErrorMarkersRemove<CR>
"}}}
""""""""""""""""""""
"qbuf {{{
""""""""""""""""""""
let g:qb_hotkey = ';bb'
"}}}
""""""""""""""""""""
"fliplr {{{
""""""""""""""""""""
nmap ,fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
xmap ,fl :FlipLR <C-R>=g:FlipLR_detectPivot()<CR>
"}}}
""""""""""""""""""""
"Ctrlp {{{
""""""""""""""""""""
"let g:ctrlp_by_filename = 0
"let g:ctrlp_lazy_update = 0
"let g:ctrlp_regexp = 0
"let g:ctrlp_follow_symlinks = 0
"let g:ctrlp_types = ['fil', 'buf', 'mru'].
"let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
"let g:ctrlp_extensions = ['tag', 'buffertag', 'dir']
let g:ctrlp_arg_map = 1
let g:ctrlp_tilde_homedir = 1
"let g:ctrlp_mruf_include = '\.c$\|\.h$'
"let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_use_caching = 10
let g:ctrlp_cache_dir = $VIMDATA.'ctrlp'
let g:ctrlp_max_files = 666
let g:ctrlp_mruf_max = 66
let g:ctrlp_max_depth = 44
"let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_switch_buffer = 'Etvh'
let g:ctrlp_open_new_file = 't' "thvr
let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 1
"let g:ctrlp_mruf_relative = 0
"let g:ctrlp_custom_ignore = {
"\ 'dir':  '\v[\/]\.(git|hg|svn)$',
"\ 'file': '\v\.(swp|exe|so|dll|zip|rar|tags|tar|7z)$',
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
"\ }

"let g:ctrlp_map = ';cc'
"nmap <silent> ;cg :CtrlPChangeAll<cr>
"nmap <silent> ;cb :CtrlPBuffer<cr>
"nmap <silent> ;cm :CtrlPMRUFiles<cr>
"nmap <silent> ;cT :CtrlPTag<cr>
"nmap <silent> ;ct :CtrlPBufTagAll<cr>
"nmap <silent> ;ci :CtrlPDir<cr>
""nmap <silent> ;cm :CtrlPBookmarkDir<cr>
""nmap <silent> ;cM :CtrlPBookmarkDirAdd<cr>
"nmap <silent> ;cr :CtrlPRTS<cr>
"nmap <silent> ;cu :CtrlPUndo<cr>
"nmap <silent> ;cl :CtrlPQuickfix<cr>
"nmap <silent> ;ca :CtrlPMixed<cr>
""nmap <silent> ;cf :CtrlPLine<cr>
"nmap <silent> ;cd :CtrlPClearCache<cr>
"nmap <silent> ;cD :CtrlPClearAllCaches<cr>
"}}}
""""""""""""""""""""
"Tagbar (similar taglist) {{{
""""""""""""""""""""
"let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_autoclose = 1
let g:tagbar_width = 28
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
"let g:tagbar_sort = 0
"let g:tagbar_expand = 0
"let g:tagbar_singleclick = 1
"let g:tagbar_foldlevel = 2
"let g:tagbar_systemenc = 'gbk'
"let g:tagbar_updateonsave_maxlines = 10000
let g:tagbar_type_ocen = {
    \ 'ctagstype' : 'ocen',
    \ 'kinds'     : [
    \ 'f:func:0:1',
    \ 't:type:1:0',
    \ ],
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/ocen.ctags'
    \ }
let g:tagbar_type_dither = {
    \ 'ctagstype' : 'dither',
    \ 'kinds'     : [
    \ 'f:func:0:1',
    \ 'v:var:0:1',
    \ 't:type:1:0',
    \ ],
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/dither.ctags'
    \ }
let g:tagbar_type_valk = {
    \ 'ctagstype' : 'valk',
    \ 'kinds'     : [
    \ 'm:macro:0:1',
    \ 't:type:0:1',
    \ 'e:enum:0:1',
    \ 'f:func:0:1',
    \ 'v:var:1:0',
    \ ],
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/valk.ctags'
    \ }

let g:tagbar_type_c2 = {
    \ 'ctagstype' : 'c2',
    \ 'kinds'     : [
    \ 'f:func:0:1',
    \ 'v:var:1:0',
    \ 't:type:0:1',
    \ 'm:mod:1:0'
    \ ],
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/c2.ctags'
    \ }
let g:tagbar_type_nature = {
    \ 'ctagstype' : 'nature',
    \ 'kinds'     : [
    \ 'f:func:0:1',
    \ 'v:var:1:0',
    \ 't:type:0:1',
    \ 'm:mod:1:0'
    \ ],
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/nature.ctags'
    \ }
let g:tagbar_type_virgil = {
    \ 'ctagstype' : 'virgil',
    \ 'kinds'     : [
    \ 'c:component:0:1',
    \ 'l:layout:0:1',
    \ 's:class:0:1',
    \ 'm:macro:0:1',
    \ 't:type:0:1',
    \ 'e:enum:0:1',
    \ 'f:func:0:1',
    \ 'a:case:1:0',
    \ 'v:var:1:0',
    \ 'n:enums:1:0',
    \ ],
    \ 'sro'          : '::',
    \ 'kind2scope'	: {
        \ 'c' : 'component',
        \ 'l' : 'layout',
        \ 's' : 'class',
        \ 'm' : 'macro',
        \ 't' : 'type',
        \ 'e' : 'enum',
    \ },
    \ 'scope2kind'	: {
        \ 'component'  : 'c',
        \ 'layout'  : 'l',
        \ 'class'   : 's',
        \ 'macro'   : 'm',
        \ 'type'    : 't',
        \ 'enum'    : 'e',
    \ },
    \ 'deffile' : expand('<sfile>:p:h:h') . '/dict/virgil.ctags'
    \ }
nmap <silent> ;tl :TagbarToggle<cr>
"}}}
""""""""""""""""""""
"NERDTree  {{{
""""""""""""""""""""
"let NERDTreeMinimalUI=1
"let NERDTreeMinimalMenu=1
let NERDTreeQuitOnOpen=1
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=0
"let NERDTreeWinPos='left'
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.o$', '\~$','\.a$','\.bak$','\.d$','\.ncb$','\.bmp$','\.exe$','\.tar\.gz$','\.7z$','\.zip$','\.rar$','\.swp$','\.dll$','\.obj$']
nmap <silent> ;tt :NERDTreeToggle <cr>
"}}}
""""""""""""""""""""
"NERD_commenter {{{
""""""""""""""""""""
"let g:NERDCustomDelimiters = {
"\ 'vim': { 'left': '#' }
"\ }
let g:NERDCreateDefaultMappings=0
if has("gui_running")
    AcSetMap('<plug>NERDCommenterToggle',     '<d-/>')
else
    AcSetMap('<plug>NERDCommenterToggle',     '<m-/>')
endif
AcSetMap('<plug>NERDCommenterComment',    ';xx')
AcSetMap('<plug>NERDCommenterMinimal',    ';xm')
AcSetMap('<plug>NERDCommenterSexy',       ';xs')
AcSetMap('<plug>NERDCommenterInvert',     ';xi')
AcSetMap('<plug>NERDCommenterYank',       ';xy')
AcSetMap('<plug>NERDCommenterAlignLeft',  ';xl')
AcSetMap('<plug>NERDCommenterAlignBoth',  ';xb')
AcSetMap('<plug>NERDCommenterNest',       ';xn')
AcSetMap('<plug>NERDCommenterUncomment',  ';xu')
AcSetMap('<plug>NERDCommenterToEOL',      ';xe')
AcSetMap('<plug>NERDCommenterAltDelims',  ';xd')
AcSetMap('<plug>NERDCommenterAppend',     ';xa')
"}}}
""""""""""""""""""""
"easymotion {{{
""""""""""""""""""""
""let EasyMotion_do_mapping = 0
""let g:EasyMotion_keys= 'asdghklqwertyuiopzxcvbnmfj;'
"let g:EasyMotion_keys = 'vcxzbtrewqyuiopnmhgasdfjkl;'
"let g:EasyMotion_leader_key = '<space>'
"let g:EasyMotion_startofline = 0
"let g:EasyMotion_do_shade = 0
"let g:EasyMotion_smartcase = 1
""let g:EasyMotion_grouping = 1
""let g:EasyMotion_use_upper = 1
"let g:EasyMotion_enter_jump_first = 1
""let g:EasyMotion_use_regexp = 1
""let g:EasyMotion_space_jump_first = 0
""let g:EasyMotion_disable_two_key_combo = 0
""let g:EasyMotion_off_screen_search = 0
""map  f <Plug>(easymotion-jumptoanywhere)
"map  f <Plug>(easymotion-bd-f)
"nmap f <Plug>(easymotion-overwin-f)
"nmap F <Plug>(easymotion-overwin-f2)
"map  F <Plug>(easymotion-bd-fn)
"map  t <Plug>(easymotion-bd-w)
"nmap  t <Plug>(easymotion-overwin-w)
"map T <Plug>(easymotion-bd-jk)
"nmap T <Plug>(easymotion-overwin-line)
"}}}
""""""""""""""""""""
"incsearch {{{
""""""""""""""""""""
""let g:incsearch#auto_nohlsearch = 1
"set hlsearch
"nmap n  <Plug>(incsearch-nohl-n)
"nmap N  <Plug>(incsearch-nohl-N)
"nmap *  <Plug>(incsearch-nohl-*)
"nmap #  <Plug>(incsearch-nohl-#)
"nmap g* <Plug>(incsearch-nohl-g*)
"nmap g# <Plug>(incsearch-nohl-g#)

"nmap /  <Plug>(incsearch-forward)
"nmap ?  <Plug>(incsearch-backward)
""map ? <Plug>(incsearch-stay)

"nmap g/ <Plug>(incsearch-fuzzy-/)
"nmap g? <Plug>(incsearch-fuzzy-/)
""nmap g? <Plug>(incsearch-fuzzy-stay)

""nmap <space>/ <Plug>(incsearch-fuzzyword-/)
""nmap <space>? <Plug>(incsearch-fuzzyword-?)
""nmap <space>g/ <Plug>(incsearch-fuzzyword-stay)

"--select *find--
"vno * y/<c-r>"<cr>

"}}}
""""""""""""""""""""
"EasyAlign {{{
""""""""""""""""""""
vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}
""""""""""""""""""""
"syntasic {{{
""""""""""""""""""""
nmap	;sk	:SyntasticCheck<CR>
nmap	;sl	:Errors<CR>
nmap	;st	:SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive',
\ 'active_filetypes': [],
\ 'passive_filetypes': [] }
"}}}
""""""""""""""""""""
"vim-markdown {{{
""""""""""""""""""""
let g:vim_markdown_fenced_languages = ['bash=sh', 'viml=vim', 'nims=nim', 'ini=dosini']
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_override_foldtext = 0
let g:tex_conceal = ""
let g:vim_markdown_auto_insert_bullets = 0
"let g:vim_markdown_auto_extension_ext = 'txt'
"let g:vim_markdown_math = 1
"let g:vim_markdown_toc_autofit = 0
"let g:vim_markdown_folding_style_pythonic = 1
"let g:vim_markdown_initial_foldlevel=3
"}}}
""""""""""""""""""""
"lightline {{{
""""""""""""""""""""
set laststatus=2
let g:lightline = {'colorscheme': 'jellybeans',}
"}}}
""""""""""""""""""""
"undotree {{{
""""""""""""""""""""
"let g:undotree_RelativeTimestamp = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3
nmap ;ut :UndotreeToggle<cr>
"}}}
""""""""""""""""""""
"auto-pairs {{{
""""""""""""""""""""
"let g:AutoPairsCompatibleMaps = 1
"let g:AutoPairsLanguagePairs = {
    "\ 'vim': {'\v^\s*\zs"': ''},
    "\ 'rust': {'\w\zs<': '>', '&\zs''': ''},
    "\ 'php': {'<?': '?>//k]', '<?php': '?>//k]'},
    "\ 'nim': { "{\.":"\.}",'`':'`'},
    "\ 'zig': { "|":"|",},
    "\ 'ocen': { '`':{'closer':'`'},},
    "\ }

"let g:pear_tree_pairs = {
            "\ '(': {'closer': ')'},
            "\ '[': {'closer': ']'},
            "\ '{': {'closer': '}'},
            "\ "'": {'closer': "'"},
            "\ '"': {'closer': '"'},
            "\ '`': {'closer': '`'}
            "\ }
"let g:pear_tree_map_special_keys = 0 " imap <BS>, <CR>, and <Esc>
"let g:pear_tree_repeatable_expand = 0 " {|} <cr> not need esc
"let g:pear_tree_smart_openers = 0
"let g:pear_tree_smart_closers = 0
"let g:pear_tree_smart_backspace = 0
"imap <BS> <Plug>(PearTreeBackspace)
"imap <CR> <Plug>(PearTreeExpand)
""imap <Esc> <Plug>(PearTreeFinishExpansion) " don't imap <esc> !!!
"imap <M-n> <Plug>(PearTreeJump)
"imap <M-i> <Plug>(PearTreeExpandOne)
"imap <M-o> <Plug>(PearTreeJNR)
"imap <M-space> <Plug>(PearTreeSpace)

"}}}
"=== building ======================{{{
com! -bang -nargs=* -range=% -complete=shellcmd AcSend FloatermSend<bang> <args>
com! -bang -nargs=* -range=% -complete=shellcmd AcRun FloatermNew<bang> --disposable --autoclose=0 --height=0.5 --width=0.98 <args>
nmap <space>r :AcSend 
nmap <space>r :AcRun 
nmap <space>R :AcRun! 
com! -nargs=+ AcFtCmd call s:AcFtCmd(<f-args>)
fu! AcFtCmd(ft,key,file,cmd, ...) abort
    let l:cmds = 'au FileType '.a:ft.' com! -bang -nargs=* -complete=file '.a:key.' ' .
    \ 'let r=fnamemodify(findfile('. string(a:file) .',".;"),":h") | if !empty(r) | exe "lcd " . r | exe '. string(a:cmd) .' | endif'
    for c in a:000
        let l:cmds .= " | ". c
    endfor
    exe l:cmds
endf
"--------------------------------------
call AcFtCmd('*','Make','Makefile','AcRun make <args>')
"au filetype c,cpp com! -bang -nargs=* -complete=file TT 
      "\ let root = fnamemodify(findfile('cex.h', '.;'), ':h') |
      "\ if !empty(root) | exe 'lcd' root | exe 'AcRun ./cex test run '.(empty(<q-args>)?'%':<q-args>) | endif
"call AcFtCmd('c,cpp','H','cex.h','AcRun ./cex help <args>')
"call AcFtCmd('c,cpp','E','cex.h','AcRun ./cex <args>')
"call AcFtCmd('c,cpp','T','cex.h','AcRun ./cex test <args>')
"call AcFtCmd('c,cpp','F','cex.h','AcRun ./cex fuzz <args>')
"call AcFtCmd('c,cpp','G','cex.h','AcRun ./cex libfetch <args>')
"call AcFtCmd('c,cpp','C','cex.h','AcRun ./cex app <args>')
"call AcFtCmd('c,cpp','CEXc','cex.h','!cc ./cex.c -o cex')
"call AcFtCmd('c,cpp','CEXh','cex.h','!cc -D CEX_NEW -x c ./cex.h -o cex && ./cex')
"call AcFtCmdEx('c,cpp','TT','cex.h','AcRun ./cex test run', '%')
"call AcFtCmdEx('c,cpp','TD','cex.h','AcRun ./cex test debug', '%')
"call AcFtCmdEx('c,cpp','CC','cex.h','AcRun ./cex app build <args>', 'myapp')
"call AcFtCmdEx('c,cpp','CD','cex.h','AcRun ./cex app debug <args>', 'myapp')
"call AcFtCmdEx('c,cpp','RR','cex.h','AcRun ./cex app run <args>', 'myapp')
"call AcFtCmdEx('c,cpp','XX','cex.h','AcRun ./cex app clean <args>', 'myapp')
au filetype c,cpp com! -bang -nargs=* -complete=file Run AcRun make -r <args>
au filetype c,cpp com! -bang -nargs=* -complete=file CC AcRun gcc <args> %:p -o %:t:r
au filetype c,cpp com! -bang -nargs=* -complete=file RR AcRun gcc <args> %:p -r -o %:t:r
au filetype nim com! -bang -nargs=* -complete=file T AcRun nim r <args> %
au filetype nim com! -bang -nargs=* -complete=file C AcRun nim <args> %
au filetype nim com! -bang -nargs=* -complete=file N AcRun nimble <args>
au filetype zig com! -bang -nargs=* -complete=file CC AcRun zig <args> %
au filetype zig com! -bang -nargs=* -complete=file C AcRun zig <args>
au filetype d com! -bang -nargs=* -complete=file C AcRun dmd <args> %
au filetype d com! -bang -nargs=* -complete=file D AcRun dub <args>
au filetype hare com! -bang -nargs=* -complete=file C AcRun hare <args> %
call AcFtCmd('ocen','C','','AcRun ocen % -o %:t:r <args>')
call AcFtCmd('ocen','R','','AcRun ocen % -o %:p:r <args> -r')
call AcFtCmd('ocen','XX','','AcRun trash %:t:r %:t:r.c')

call AcFtCmd('nature','C','package.toml','AcRun nature build <args> -o %:t:r %')
call AcFtCmd('nature','TT','','AcRun! nature build <args> % && ./main <args>', 'AcSend exit')
"au filetype nature com! -bang -nargs=* -complete=file TT exe 'AcRun! nature build <args> % && ./main' | exe 'AcSend exit'

"let $RUST_BACKTRACE='full'
"let $RUST_BACKTRACE=1
let $MAKEPAD='lines'
"--nocapture 测试里显示打印
"--show-output 测试里显示更多内容
call AcFtCmd('rust','RD','Cargo.toml','AcRun cargo +nightly run <args>')
call AcFtCmd('rust','BD','Cargo.toml','AcRun cargo +nightly build <args>')
call AcFtCmd('rust','RE','Cargo.toml','AcRun cargo run --example=%:t:r <args> --release')
call AcFtCmd('rust','RD','Cargo.toml','AcRun cargo run <args>')
call AcFtCmd('rust','R','Cargo.toml','AcRun cargo run <args> --release')
call AcFtCmd('rust','T','Cargo.toml','AcRun cargo test <args>')
call AcFtCmd('rust','BD','Cargo.toml','AcRun cargo build <args>')
call AcFtCmd('rust','B','Cargo.toml','AcRun cargo build <args> --release')
call AcFtCmd('rust','E','Cargo.toml','AcRun cargo check <args>')
call AcFtCmd('rust','C','Cargo.toml','AcRun cargo <args>')
call AcFtCmd('rust','XX','Cargo.toml','AcRun cargo clean <args>')
call AcFtCmd('rust','TT','Cargo.toml','AcRun cargo test <args> -- --nocapture')
au filetype rust com! -bang -nargs=* -complete=file XT AcRun trash %:t:r 
au filetype rust com! -bang -nargs=* -complete=file RT exe 'AcRun! rustc <args> % && ./%:t:r' | exe 'AcSend exit'

call AcFtCmd('axe','RE','axe.mod','AcRun saw run <args> --release')
call AcFtCmd('axe','R','axe.mod','AcRun saw run <args>')
call AcFtCmd('axe','CT','axe.mod','AcRun saw test <args>')
call AcFtCmd('axe','C','axe.mod','AcRun saw <args>')
call AcFtCmd('axe','XX','axe.mod','AcRun saw clean <args>')
call AcFtCmd('axe','TC','axe.mod','AcRun axe % <args> --syntax-check')
call AcFtCmd('axe','T','axe.mod','AcRun axe % <args> -r -q')
call AcFtCmd('axe','AD','axe.mod','AcRun axe % <args>')
call AcFtCmd('axe','A','axe.mod','AcRun axe % <args> --release')

call AcFtCmd('dither','T','makefile','AcRun dither <args> -x %')
call AcFtCmd('dither','C','makefile','AcRun dither <args> %')
call AcFtCmd('dither','Chtml','makefile','AcRun dither <args> -t html -o %:p:r:~.html %')
call AcFtCmd('dither','Cc','makefile','AcRun dither <args> -t c -o %:p:r:~.c %')
call AcFtCmd('dither','Cjs','makefile','AcRun dither <args> -t c -o %:p:r:~.js %')

call AcFtCmd('valk','TT','valk.json','AcRun valk build -t -v <args> %')
call AcFtCmd('valk','T','valk.json','AcRun valk build -t <args> %')
call AcFtCmd('valk','CR','valk.json','AcRun valk build -r <args> % -o %:p:r:~')
call AcFtCmd('valk','C','valk.json','AcRun valk build <args> % -o %:p:r:~')
call AcFtCmd('valk','R','valk.json','AcRun valk build -r <args> %')
call AcFtCmd('valk','V','valk.json','AcRun valk <args> %')
call AcFtCmd('valk','XX','valk.json','AcRun valk build -c <args> %')
call AcFtCmd('valk','D','valk.json','AcRun valk doc %:p:h:~ --no-private <args>')
call AcFtCmd('valk','DD','valk.json','AcRun valk doc %:p:h:~ --no-private --markdown <args>')
call AcFtCmd('valk','Do','valk.json','AcRun valk doc %:p:h:~ --no-private -o %:p:r:~.json <args>')
call AcFtCmd('valk','DDo','valk.json','AcRun valk doc %:p:h:~ --no-private --markdown -o %:p:r:~.md <args>')

call AcFtCmd('quark','C','','AcRun! qc % -o %:t:r.c -l '.$QUARK_ROOT.' <args>', 'AcSend exit')
call AcFtCmd('quark','TT','','AcRun! qc % -o %:t:r.c -l '.$QUARK_ROOT.' <args> && gcc %:t:r.c -o %:t:r && ./%:t:r', 'AcSend exit')
call AcFtCmd('quark','T','','AcRun! qc % -o %:t:r.c -l '.$QUARK_ROOT.' <args> && gcc %:t:r.c -o %:t:r', 'AcSend exit')
call AcFtCmd('quark','XX','','AcRun trash %:p:r %:p:r.c')
"au filetype quark com! -bang -nargs=* -complete=file TT exe 'AcRun! qc % -o %:t:r.c -l '.$QUARK_ROOT.' && gcc %:t:r.c -o %:t:r && ./%:t:r' | exe 'AcSend exit'
au filetype adept com! -bang -nargs=* -complete=file CC AcRun adept <args> %:p
au filetype adept com! -bang -nargs=* -complete=file RR AcRun adept -e <args> %:p
au filetype c2 com! -bang -nargs=* -complete=file TT AcRun tester <args> %:p
au filetype c2 com! -bang -nargs=* -complete=file CC AcRun c2c <args> %:p
au filetype c2 com! -bang -nargs=* -complete=file CT AcRun c2c --test <args> %:p
au filetype c2 com! -bang -nargs=* -complete=file CR AcRun c2c <args> && ./run
au filetype c2 com! -bang -nargs=* -complete=file C AcRun c2c <args>
au filetype c2 com! -bang -nargs=* -complete=file Test AcRun c2c --test <args>
au filetype c3 com! -bang -nargs=* -complete=file CC AcRun c3c compile <args> %:p
au filetype litac com! -bang -nargs=* -complete=file CC AcRun litac -disableLine <args> %:p -o %:t:r
au filetype litac com! -bang -nargs=* -complete=file RR AcRun litac -disableLine -run <args> %:p -o %:t:r
au filetype litac com! -bang -nargs=* -complete=file TT AcRun litac <args> -testFile %:p

au filetype virgil com! -bang -nargs=* -complete=file TE AcRun v3i <args> %:p
au filetype virgil com! -bang -nargs=* -complete=file TT AcRun make test SRC=%:p <args>
au filetype virgil com! -bang -nargs=* -complete=file CC AcRun make build SRC=%:p <args>
au filetype virgil com! -bang -nargs=* -complete=file CR AcRun make run SRC=%:p <args>
au filetype virgil com! -bang -nargs=* -complete=file T AcRun make test 
au filetype virgil com! -bang -nargs=* -complete=file B AcRun make build NAME=<args>
au filetype virgil com! -bang -nargs=* -complete=file RR AcRun make run NAME=<args>
au filetype virgil com! -bang -nargs=* -complete=file XX AcRun make clean NAME=%:t:r 
"NAME=<args>

"}}}
""""""""""""""""""""
"floaterm {{{
""""""""""""""""""""
let g:floaterm_width = 0.98
let g:floaterm_height = 0.9
let g:floaterm_autoclose = 0
let g:floaterm_position = 'bottom'
let g:floaterm_keymap_toggle = '<m-space>'
let g:floaterm_keymap_kill   = '<m-q>'
"let g:floaterm_keymap_new    = '<m-N>'
"let g:floaterm_keymap_prev   = '<m-k>'
"let g:floaterm_keymap_next   = '<m-j>'
"let g:floaterm_keymap_first  = '<m-h>'
"let g:floaterm_keymap_last   = '<m-l>'
tnoremap   <silent>   <esc>    <C-\><C-n>
nnoremap   <silent>   <m-o>    :FloatermNew --disposable<CR>
tnoremap   <silent>   <m-o>    <C-\><C-n>:FloatermNew --disposable<CR>
tnoremap   <silent>   <m-p>    <C-\><C-n>:FloatermPrev<CR>
tnoremap   <silent>   <m-n>    <C-\><C-n>:FloatermNext<CR>
"tnoremap   <silent>   <m-h>    <C-\><C-n>:FloatermFirst<CR>
"tnoremap   <silent>   <m-l>    <C-\><C-n>:FloatermLast<CR>
"}}}
""""""""""""""""""""
"vsnip {{{
""""""""""""""""""""
let g:vsnip_snippet_dir = $VIM.'snippets/'
"imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
"smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
imap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <c-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <c-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
"}}}
""""""""""""""""""""
"lsp {{{
""""""""""""""""""""
com! -nargs=+ GotoRead call GotoRead<args> "{{{
fu! GotoRead(cmd) abort
	let l:bnr = bufnr('%')
	exe a:cmd
	if bufnr('%') != l:bnr
		setl readonly nomodifiable
	endif
endf "}}}

"set keywordprg=:LspHover
nmap <buffer> ;tL <Cmd>LspOutline<cr>
nmap <buffer> K <Cmd>LspHover<cr>
nmap <silent> <space>k <Cmd>LspHover<cr>
"nmap <c-]> <Cmd>LspGotoDefinition<CR>
"nmap <c-s-]> <Cmd>topleft LspGotoDefinition<CR>
"nmap ge <Cmd>LspGotoDefinition<CR>
"nmap ge <Cmd>silent! :let bnr = bufnr('%') \| LspGotoDefinition \| if bufnr('%') != bnr \| setlocal readonly nomodifiable \| endif<CR>
nmap ge :GotoRead('LspGotoDefinition')<CR>
"nmap ga <Cmd>LspGotoDeclaration<CR>
nmap ga :GotoRead('LspGotoDeclaration')<CR>
"nmap ge <Cmd>LspPeekDeclaration<CR>
"nmap gE <Cmd>LspPeekDefinition<CR>
"nmap <C-W>gd <Cmd>topleft LspGotoDefinition<CR>
"nmap gi <Cmd>LspGotoImpl<CR>
nmap gi :GotoRead('LspGotoImpl')<CR>
"nmap gt <Cmd>LspGotoTypeDef<CR>
nmap gt :GotoRead('LspGotoTypeDef')<CR>
"nmap gi <Cmd>LspPeekImpl<CR>
"nmap gt <Cmd>LspPeekTypeDef<CR>
nmap g[ <Cmd>LspDiagPrev<CR>
nmap g] <Cmd>LspDiagNext<CR>
"nmap gs <Cmd>LspSymbolSearch<CR>
"nmap gS <Cmd>LspDocumentSymbol<CR>
"nmap gr <Cmd>LspPeekReferences<CR>
nmap gR <Cmd>LspShowReferences<CR>
nmap g\ <Cmd>LspServer restart<CR>

au filetype c,cpp call LspAddServer([#{
            \    name: 'clangd',
            \    filetype: ['c', 'cpp'],
            \    path: 'clangd',
            \    args: ['--background-index']
            \  }])

"SetFt('*.zc','zc')
"au filetype zenc call LspAddServer([#{
            "\    name: 'zc',
            "\    filetype: ['zc'],
            "\    path: 'zc',
            "\    args: ['lsp']
            "\  }])

au filetype quark call LspAddServer([#{
            \    name: 'quark',
            \    filetype: ['quark'],
            \    path: 'clangd',
            \    args: ['--background-index']
            \  }])

au filetype dither call LspAddServer([#{
            \    name: 'dither',
            \    filetype: ['dither'],
            \    path: 'clangd',
            \    args: ['--background-index']
            \  }])

au filetype valk call LspAddServer([#{
            \    name: 'valk',
            \    filetype: ['valk'],
            \    path: 'valk',
            \    args: ['lsp','run']
            \  }])

"au filetype ocen call LspAddServer([#{
            "\    name: 'ocen',
            "\    filetype: ['ocen'],
            "\    path: 'clangd',
            "\    args: ['--background-index']
            "\  }])

"au filetype ocen call LspAddServer([#{
            "\    name: 'ocen',
            "\    filetype: ['ocen'],
            "\    path: 'ocen',
            "\    args: ['lsp-server']
            "\  }])

"au filetype c2 call LspAddServer([#{
            "\    name: 'clangd',
            "\    filetype: ['c', 'cpp', 'c2'],
            "\    path: 'clangd',
            "\    args: ['--background-index']
            "\  }])

"au filetype c2 call LspAddServer([#{
            "\    name: 'c2lsp',
            "\    filetype: ['c2'],
            "\    path: 'c2lsp',
            "\  }])

au filetype nim call LspAddServer([#{
            \    name: 'nimlsp',
            \    filetype: ['nim'],
            \    path: 'nimlsp',
            \  }])

au filetype zig call LspAddServer([#{
            \    name: 'zls',
            \    filetype: ['zig'],
            \    path: 'zls',
            \  }])

"au filetype rust call LspAddServer([#{
            "\    name: 'rust-analyzer',
            "\    filetype: ['rust'],
            "\    path: exepath('rust-analyzer'),
            "\    args: [],
            "\    syncInit: v:true,
            "\  }])

      "\             'features': 'all', 
      "\             'extraArgs': ["--target-dir","/tmp/rust-analyzer-target"], 
au FileType rust call LspAddServer([{
      \ 'name': 'rust-analyzer',
      \ 'filetype': ['rust'],
      \ 'path': exepath('_rust-analyzer'),
      \ 'args': [],
      \ 'rootSearch': ['Cargo.toml', 'rust-project.json'],
      \ 'syncInit': v:true,
      \ 'allowStdio': v:false,
      \ 'debounceTextChanges': 100,
      \ 'initializationOptions': {
      \     'rust-analyzer': {
      \         'cargo': { 
      \             'features': [], 
      \             'allTargets': v:false,
      \             'buildScripts': {'enable': v:false},
      \             'loadOutDirsFromCheck': v:false,
      \             'noDefaultFeatures': v:true,
      \             'noDeps': v:true,
      \             'target': '',
      \         },
      \         'cachePriming': { 'enable': v:false },
      \         'procMacro': { 'enable': v:false },
      \         'checkOnSave': { 'enable': v:false, 'command': 'clippy' },
      \         'imports': { 'group': { 'enable': v:false } },
      \         'hover': { 'enable': v:true, 'documentation.enable': v:false },
      \         'inlayHints': { 'enable': v:false },
      \         'semanticHighlighting': { 'enable': v:false },
      \         'check': { 'enable': v:false },
      \         'assist': { 
      \             'enable': v:false,
      \             'termSearch': { 'fuel': 50 },
      \         },
      \         'completion': { 
      \             'enable': v:true,
      \             'termSearch': { 'fuel': 50 },
      \             'postfix': { 'enable': v:false },
      \         },
      \         'diagnostics': { 'enable': v:false },
      \         'highlightRelated': { 'enable': v:false },
      \         'lens': { 'enable': v:false },
      \     }
      \ }
      \ }])

au filetype adept call LspAddServer([#{
            \    name: 'adeptls',
            \    filetype: ['adept'],
            \    path: 'adeptls',
            \    args: ['--infrastructure', $HOME..'/SDK/Adepts/_bin/']
            \  }])

"au filetype litac call LspAddServer([#{
            "\    name: 'litac',
            "\    filetype: ['litac'],
            "\    path: 'litac',
            "\    args: ['-languageServer']
            "\  }])
            ""\    args: ['-languageServer', $HOME..'/SDK/LitaCs/litac-lang']

au filetype d call LspAddServer([#{
            \    name: 'd',
            \    filetype: ['d'],
            \    path: 'serve-d',
            \  }])

"au filetype nature call LspAddServer([#{
            "\    name: 'nature',
            "\    filetype: ['nature'],
            "\    path: 'nls',
            "\  }])

au filetype axe call LspAddServer([#{
            \    name: 'axe',
            \    filetype: ['axe'],
            \    path: 'axels',
            \  }])

"au filetype v call LspAddServer([#{
            "\    name: 'vls',
            "\    filetype: ['vlang', 'v'],
            "\    path: 'vls',
            "\  }])
            
"au filetype virgil call LspAddServer([#{
            "\    name: 'virgil',
            "\    filetype: ['virgil'],
            "\    path: 'virgil-lsp',
            "\    args: [],
            "\    syncInit: v:true,
            "\  }])


setl omnifunc=LspOmniFunc
"setl completefunc=LspOmniFunc
"setl tagfunc=LspOmniFunc
au filetype * call LspOptionsSet(#{
        \   outlineOnRight: v:true,
        \   outlineWinSize: 30,
        \   autoHighlightDiags: v:false,
        \   showDiagInBalloon: v:false,
        \   aleSupport: v:false,
        \   autoComplete: v:false,
        \   snippetSupport: v:false,
        \   vsnipSupport: v:true,
        \   bufferCompletionTimeout: 100,
        \   filterCompletionDuplicates: v:true,
        \   completionMatcher: 'fuzzy',
        \   showSignature: v:true,
        \ })

        "\   showSignature: v:true,
        "\   omniComplete: true,
        "\   completionMatcher: 'fuzzy',
        "\   filterCompletionDuplicates: v:true,
        "\   showSignature: v:true,
        "\   semanticHighlight: v:false,
        "\   completionMatcher: 'fuzzy',
        "\   showSignature: v:true,
        "\   hoverInPreview: v:false,
        "\   keepFocusInDiags: v:false,
        "\   keepFocusInReferences: v:false,
        "\   highlightDiagInline: v:false,
        "\   completionTextEdit: v:false,
        "\   semanticHighlight: v:false,
        "\   autoHighlightDiags: v:true,
        "\   showDiagWithSign: v:true,
        "\   showDiagInBalloon: v:false,
        "\   showDiagInPopup: v:false,
        "\   showSignature: v:false,
        "\   condensedCompletionMenu: v:false,
        "\   usePopupInCodeAction: v:false,

"}}}
""""""""""""""""""""
"another {{{
""""""""""""""""""""
"}}}
"-------------------------
"Custom settings
"You can see maps
":verbose nmap ;
"-------------------------
