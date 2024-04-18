vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 1
var dictproperties = {
        #zig: {sortedDict: true }
    }
export var options = {
    completor: { 
        shuffleEqualPriority: true,
    },
    buffer: { 
        enable: true,
        priority: 10,
        searchOtherBuffers: false,
        urlComplete: true,
        envComplete: true,
        #timeout: 100,
        completionMatcher: 'fuzzy',
    },
    abbrev: { enable: true, priority: 10 },
    lsp: { enable: true, priority: 11, maxCount: 16 },
    dictionary: { 
        enable: true,
        matcher: 'case',
        #matcher: 'ignorecase',
        onlyWords: false,
        sortedDict: true,
        maxCount: 10,
        filetypes: ['*'],
        #timeout: 100,
        priority: 6,
        properties: dictproperties,
    },
    omnifunc: { enable: false, priority: 8, filetypes: ['python', 'javascript'] },
    vsnip: { enable: true, priority: 11, timeout: 100 },
    vimscript: { enable: true },
    ngram: {
        enable: true,
        priority: 10,
        bigram: false,
        filetypes: ['txt', 'markdown'],
        #filetypesComments: ['c', 'cpp', 'python', 'nim', 'zig', 'rust'],
        filetypesComments: ['*'],
    },
}
autocmd VimEnter * g:VimCompleteOptionsSet(options)

#---autosuggest
export var asopt = {
    search: {
        enable: true,   # 'false' will disable search completion
        maxheight: 10,  # line count of stacked menu
        pum: true,      # 'false' for flat menu, 'true' for stacked menu
        fuzzy: false,   # fuzzy completion
        alwayson: true, # when 'false' press <tab> to open popup menu
    },
    cmd: {
        enable: true,   # 'false' will disable command completion
        #delay: 10,      # delay in ms before showing popup
        pum: true,      # 'false' for flat menu, 'true' for stacked menu
        fuzzy: false,   # fuzzy completion
        #exclude: ["[pP]"],    # keywords excluded from completion (use \c for ignorecase)
        onspace: [],    # show popup menu after keyword+space (ex. :buffer<space>, etc.)
    }
}
autocmd VimEnter * g:AutoSuggestSetup(asopt)

import autoload 'scope/fuzzy.vim'
nmap <c-l> <scriptcmd>fuzzy.Quickfix()<CR>
nmap <c-L> <scriptcmd>fuzzy.Quickfix()<CR>
nmap g/ <scriptcmd>fuzzy.BufSearch()<CR>
vmap g/ <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nmap g? <scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
vmap g? <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nmap ;ff <scriptcmd>fuzzy.File()<CR>
vmap ;ff <esc><scriptcmd>fuzzy.File()<CR><c-r><c-w>
nmap ;fF <scriptcmd>fuzzy.File()<CR><c-r><c-w>
nmap ;g/ <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR>
vmap ;g/ <esc><scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR><c-r><c-w>
nmap ;g? <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case', false, '<cword>')<CR>
nmap ;fg <scriptcmd>fuzzy.GitFile()<CR>
#emap ;fb <scriptcmd>fuzzy.Buffer(true)<CR>
nmap ;fb <scriptcmd>fuzzy.Buffer()<CR>
nmap ;fk <scriptcmd>fuzzy.Keymap()<CR>
nmap ;fh <scriptcmd>fuzzy.Help()<CR>
nmap ;fl <scriptcmd>fuzzy.Highlight()<CR>
nmap ;fc <scriptcmd>fuzzy.Command()<CR>
nmap ;fH <scriptcmd>fuzzy.CmdHistory()<CR>
nmap ;fu <scriptcmd>fuzzy.MRU()<CR>
nmap ;fm <scriptcmd>fuzzy.Mark()<CR>
nmap ;fo <scriptcmd>fuzzy.Option()<CR>
nmap ;fr <scriptcmd>fuzzy.Register()<CR>
nmap ;ft <scriptcmd>fuzzy.Tag()<CR>
nmap ;fw <scriptcmd>fuzzy.Window()<CR>
nmap ;fA <scriptcmd>fuzzy.Autocmd()<CR>
nmap ;fy <scriptcmd>fuzzy.Filetype()<CR>
nmap ;fY <scriptcmd>fuzzy.Colorscheme()<CR>

