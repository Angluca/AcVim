vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 1
var dictproperties = {
        zig: {sortedDict: true }
    }
export var options = {
    completor: { shuffleEqualPriority: true },
    buffer: { enable: true, priority: 10, urlComplete: true, envComplete: true },
    abbrev: { enable: true, priority: 10 },
    lsp: { enable: true, priority: 11, maxCount: 16 },
    dictionary: { 
        enable: true,
        matcher: 'case',
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
        filetypesComments: ['c', 'cpp', 'python', 'nim', 'zig'],
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
        exclude: [],    # keywords excluded from completion (use \c for ignorecase)
        onspace: [],    # show popup menu after keyword+space (ex. :buffer<space>, etc.)
    }
}
autocmd VimEnter * g:AutoSuggestSetup(asopt)

