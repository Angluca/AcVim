vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 1
var dictproperties = {
        zig: {sortedDict: true }
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
        pum: true,      # 'false' for flat menu, 'true' for stacked menu
        fuzzy: false,   # fuzzy completion
        exclude: ["[pP]"],    # keywords excluded from completion (use \c for ignorecase)
        onspace: [],    # show popup menu after keyword+space (ex. :buffer<space>, etc.)
    }
}
autocmd VimEnter * g:AutoSuggestSetup(asopt)

import autoload 'scope/fuzzy.vim'
nnoremap <c-l> <scriptcmd>fuzzy.Quickfix()<CR>
nnoremap <c-L> <scriptcmd>fuzzy.Quickfix()<CR>
nnoremap g/ <scriptcmd>fuzzy.BufSearch()<CR>
vnoremap g/ <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
nnoremap g? <scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
vnoremap g? <esc><scriptcmd>fuzzy.BufSearch()<CR><c-r><c-w>
#nnoremap gD <scriptcmd>fuzzy.BufSearch('<cword>')<CR>
nnoremap ;ff <scriptcmd>fuzzy.File()<CR>
vnoremap ;ff <esc><scriptcmd>fuzzy.File()<CR><c-r><c-w>
nnoremap ;fF <scriptcmd>fuzzy.File()<CR><c-r><c-w>
nnoremap ;g/ <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR>
vnoremap ;g/ <esc><scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR><c-r><c-w>
nnoremap ;g? <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case', false, '<cword>')<CR>
nnoremap ;fg <scriptcmd>fuzzy.GitFile()<CR>
#nnoremap ;fb <scriptcmd>fuzzy.Buffer(true)<CR>
nnoremap ;fb <scriptcmd>fuzzy.Buffer()<CR>
nnoremap ;fk <scriptcmd>fuzzy.Keymap()<CR>
nnoremap ;fh <scriptcmd>fuzzy.Help()<CR>
nnoremap ;fH <scriptcmd>fuzzy.Highlight()<CR>
nnoremap ;fc <scriptcmd>fuzzy.Command()<CR>
nnoremap ;fC <scriptcmd>fuzzy.CmdHistory()<CR>
nnoremap ;fu <scriptcmd>fuzzy.MRU()<CR>
nnoremap ;fm <scriptcmd>fuzzy.Mark()<CR>
nnoremap ;fo <scriptcmd>fuzzy.Option()<CR>
nnoremap ;fr <scriptcmd>fuzzy.Register()<CR>
nnoremap ;ft <scriptcmd>fuzzy.Tag()<CR>
nnoremap ;fw <scriptcmd>fuzzy.Window()<CR>
nnoremap ;fA <scriptcmd>fuzzy.Autocmd()<CR>
nnoremap ;fy <scriptcmd>fuzzy.Filetype()<CR>
nnoremap ;fY <scriptcmd>fuzzy.Colorscheme()<CR>
#nnoremap ;ff <scriptcmd>fuzzy.Autocmd()<CR>
#nnoremap ;fc <scriptcmd>fuzzy.Command()<CR>
#nnoremap ;ff <scriptcmd>fuzzy.QuickfixHistory()<CR>
#nnoremap ;fF <scriptcmd>fuzzy.LoclistHistory()<CR>

