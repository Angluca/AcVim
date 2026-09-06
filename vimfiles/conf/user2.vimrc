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
        range: 50,
        timeout: 10,
        async: true,
        async_timeout: 200,
        async_minlines: 20,
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
au VimEnter * call g:VimSuggestSetOptions(g:vimsuggestOpt)

#-- scope ------
import autoload 'scope/fuzzy.vim'
nn <C-q> <scriptcmd>fuzzy.Quickfix()<CR>
nn ;/ <scriptcmd>fuzzy.BufSearch()<CR>
xn ;/ <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nn ;? <scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
xn ;? <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nn ;ff <scriptcmd>fuzzy.File()<CR>
xn ;ff <esc><scriptcmd>fuzzy.File()<CR><c-r><c-w>
nn ;fF <scriptcmd>fuzzy.File()<CR><c-r><c-w>
nn ;f/ <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR>
xn ;f/ <esc><scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR><c-r><c-w>
nn ;f? <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case', false, '<cword>')<CR>
#nmap ;fG <scriptcmd>fuzzy.GitFile()<CR>
#emap ;fb <scriptcmd>fuzzy.Buffer(true)<CR>
nn ;fb <scriptcmd>fuzzy.Buffer()<CR>
nn ;fk <scriptcmd>fuzzy.Keymap()<CR>
nn ;fh <scriptcmd>fuzzy.Help()<CR>
nn ;fl <scriptcmd>fuzzy.Highlight()<CR>
nn ;fc <scriptcmd>fuzzy.Command()<CR>
nn ;fi <scriptcmd>fuzzy.CmdHistory()<CR>
nn ;fu <scriptcmd>fuzzy.MRU()<CR>
nn ;fm <scriptcmd>fuzzy.Mark()<CR>
nn ;fo <scriptcmd>fuzzy.Option()<CR>
nn ;fr <scriptcmd>fuzzy.Register()<CR>
nn ;ft <scriptcmd>fuzzy.Tag()<CR>
nn ;fw <scriptcmd>fuzzy.Window()<CR>
nn ;fA <scriptcmd>fuzzy.Autocmd()<CR>
nn ;fy <scriptcmd>fuzzy.Filetype()<CR>
nn ;fL <scriptcmd>fuzzy.Colorscheme()<CR>

