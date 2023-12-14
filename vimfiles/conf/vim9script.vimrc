vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 1
export var options: dict<any>
options = {
#export var options = {
    completor: { shuffleEqualPriority: true },
    buffer: { enable: true, priority: 11, timeout: 6, urlComplete: true, envComplete: true },
    abbrev: { enable: false, priority: 10 },
    dictionary: { enable: true, maxCount: 6000, timeout: 6, maxPop: 66, priority: 6, icase: true },
    lsp: { enable: true, priority: 12, maxCount: 10 },
    omnifunc: { enable: false, priority: 8, filetypes: ['python', 'javascript'] },
    vsnip: { enable: true, priority: 11 },
    #vimscript: { enable: true, priority: 11 },
    #ngram: {
        #enable: true,
        #priority: 10,
        #bigram: false,
        #filetypes: ['text', 'help', 'markdown'],
        #filetypesComments: ['c', 'cpp', 'python', 'java', 'nim'],
    #},
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
        fuzzy: true,   # fuzzy completion
        exclude: [],    # keywords excluded from completion (use \c for ignorecase)
        onspace: [],    # show popup menu after keyword+space (ex. :buffer<space>, etc.)
    }
}
autocmd VimEnter * g:AutoSuggestSetup(asopt)
