vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 1
export var options: dict<any> = {
    completor: { shuffleEqualPriority: true },
    buffer: { enable: true, priority: 10, timeout: 10, urlComplete: true, envComplete: true },
    abbrev: { enable: true, priority: 10 },
    dictionary: { enable: false, maxCount: 20, maxWords: 8000, timeout: 10, priority: 6, icase: false },
    lsp: { enable: false, priority: 11, maxCount: 10 },
    omnifunc: { enable: false, priority: 8, filetypes: ['python', 'javascript'] },
    vsnip: { enable: false, priority: 10 },
    vimscript: { enable: false, priority: 11 },
    #ngram: {
        #enable: true,
        #priority: 10,
        #bigram: false,
        #filetypes: ['text', 'help', 'markdown'],
        #filetypesComments: ['c', 'cpp', 'python', 'java', 'nim'],
    #},
}
    #dictionary: { enable: false, maxCount: 6000, maxPop: 10, timeout: 6, priority: 6, icase: false },

#autocmd VimEnter * g:VimCompleteOptionsSet(options)

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
        fuzzy: true,   # fuzzy completion
        exclude: [],    # keywords excluded from completion (use \c for ignorecase)
        onspace: [],    # show popup menu after keyword+space (ex. :buffer<space>, etc.)
    }
}
autocmd VimEnter * g:AutoSuggestSetup(asopt)

