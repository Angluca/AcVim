vim9script

#-- vimsuggest ------
g:vimsuggestOpt = {
    search: {
        enable: true,
        pum: true,
        fuzzy: false,
        alwayson: true,
        popupattrs: {
            maxheight: 12,
        },
        range: 100,
        timeout: 100,
        async: true,
        async_timeout: 200,
        async_minlines: 200,
        highlight: true,
        trigger: 't',
        reverse: false,
        prefixlen: 1,
    },
    cmd: {
        enable: true,
        pum: true,
        exclude: [],
        onspace: ['colo\%[rscheme]', 'b\%[uffer]', 'sy\%[ntax]'],
        # Complete after the space after the command
        alwayson: true,
        popupattrs: {},
        wildignore: true,
        addons: true,
        trigger: 't',
        reverse: false,
        auto_first: false,
        prefixlen: 1,
        complete_sg: true,
    },
    keymap: {
        page_up: ["\<M-k>"],
        page_down: ["\<M-j>"],
        hide: "\<C-l>",
        dismiss: "",
        send_to_qflist: "\<M-q>",
        send_to_arglist: "",
        send_to_clipboard: "",
        split_open: "",
        vsplit_open: "",
        tab_open: "",
    }
}
au VimEnter * g:VimSuggestSetOptions(g:vimsuggestOpt)

#-- scope ------
import autoload 'scope/fuzzy.vim'
nmap <C-l> <scriptcmd>fuzzy.Quickfix()<CR>
nmap <C-L> <scriptcmd>fuzzy.Quickfix()<CR>
nmap ;/ <scriptcmd>fuzzy.BufSearch()<CR>
vmap ;/ <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nmap ;? <scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
vmap ;? <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nmap ;ff <scriptcmd>fuzzy.File()<CR>
vmap ;ff <esc><scriptcmd>fuzzy.File()<CR><c-r><c-w>
nmap ;fF <scriptcmd>fuzzy.File()<CR><c-r><c-w>
nmap ;f/ <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR>
vmap ;f/ <esc><scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR><c-r><c-w>
nmap ;f? <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case', false, '<cword>')<CR>
#nmap ;fG <scriptcmd>fuzzy.GitFile()<CR>
#emap ;fb <scriptcmd>fuzzy.Buffer(true)<CR>
nmap ;fb <scriptcmd>fuzzy.Buffer()<CR>
nmap ;fk <scriptcmd>fuzzy.Keymap()<CR>
nmap ;fh <scriptcmd>fuzzy.Help()<CR>
nmap ;fl <scriptcmd>fuzzy.Highlight()<CR>
nmap ;fc <scriptcmd>fuzzy.Command()<CR>
nmap ;fC <scriptcmd>fuzzy.CmdHistory()<CR>
nmap ;fu <scriptcmd>fuzzy.MRU()<CR>
nmap ;fm <scriptcmd>fuzzy.Mark()<CR>
nmap ;fo <scriptcmd>fuzzy.Option()<CR>
nmap ;fr <scriptcmd>fuzzy.Register()<CR>
nmap ;ft <scriptcmd>fuzzy.Tag()<CR>
nmap ;fw <scriptcmd>fuzzy.Window()<CR>
nmap ;fA <scriptcmd>fuzzy.Autocmd()<CR>
nmap ;fy <scriptcmd>fuzzy.Filetype()<CR>
nmap ;fL <scriptcmd>fuzzy.Colorscheme()<CR>

defcompile
