vim9script

#---lsp/omnifunc/vimcomplete
#g:vimcomplete_tab_enable = 0
#g:vimcomplete_cr_enable = 0

#export var vimcompleteOpt = {
    #completor: { 
        #noNewlineInCompletion: false,
        #noNewlineInCompletionEver: false,
        #matchCase: true,
        #sortByLength: false,
        #recency: true,
        #recentItemCount: 5,
        #shuffleEqualPriority: true,
        #alwaysOn: true,
        #setCompleteOpt: false, # true: cot=menuone,noinsert,noselect
        #infoPopup: true, # true: cot+=popuphidden
        #showCmpSource: true,
        #cmpSourceWidth: 4,
        #showKind: true,
        #customCompletionKinds: false,
        #completionKinds: {},
        #kindDisplayType: '', # 'symbol', 'icon', 'icontext', 'text', 'symboltext', 'symbol', 'text'
        #postfixClobber: false,  # remove yyy in xxx<cursor>yyy
        #postfixHighlight: false, # highlight yyy in xxx<cursor>yyy
        #triggerWordLen: 0, # default 0 can popup path ./../..
        #throttleTimeout: 1,
    #},
    #buffer: { 
        #priority: 10,
        #timeout: 90,                # Match this with throttle timeout in completor
        #maxCount: 10,
        #otherBuffersCount: 3,       # Max count of other listed buffers to search
        #completionMatcher: 'icase', # 'case', 'fuzzy', 'icase'
        #urlComplete: true,
        #envComplete: true,
        #maxWordLen: 100,            # Words beyond this length are ignored
        #dup: true,
    #},
    #dictionary: { 
        #priority: 6, 
        #enable: true,
        #matcher: 'icase', # 'case', 'ignorecase'. active for sortedDict or onlyWords is true,
        #maxCount: 10,
        #sortedDict: true,
        #onlyWords: false, # [0-9z-zA-Z] if true, else any non-space char is allowed (sorted=false assumed)
        #commentStr: '---',
        #triggerWordLen: 1,
        #timeout: 0, # not implemented yet
        #dup: false, # suppress duplicates
        #filetypes: ['*'],
        #matchStr: '\k\+$',
        #matchAny: false,
        #info: false,  # Whether 'info' popup needs to be populated
    #},
    #tmux: {
        #enable: false,
        #dup: false,
        #maxCount: 10,
        #scrollCount: 200,
        #completionMatcher: 'icase', # 'case', 'fuzzy', 'icase'
        #name: 'tmux',    
    #},
    #tag: { enable: true, maxCount: 10 },
    #abbrev: { priority: 10, enable: true, maxCount: 10 },
    #vimscript: { enable: true, maxCount: 10 },
    #lsp: { priority: 11, enable: true, maxCount: 16, keywordOnly: false },
    #vsnip: { priority: 11, enable: true, maxCount: 10, adaptNonKeyword: false },
    #omnifunc: { priority: 8, enable: false, maxCount: 10, partialWord: ['python3complete#Complete'] },
#}
#autocmd VimEnter * g:VimCompleteOptionsSet(vimcompleteOpt)

#---vimsuggest
export var vimsuggestOpt = {
    search: {
        enable: true,         # Enable/disable the feature globally
        pum: false,            # 'false' for flat, 'true' for vertically stacked popup menu
        fuzzy: false,         # Enable/disable fuzzy completion
        alwayson: true,       # Open popup menu on <tab> if 'false'
        popupattrs: {         # Attributes passed to the popup window
            maxheight: 12,    # Maximum height for the stacked menu (when pum=true)
        },
        range: 100,           # Number of lines to search in each batch
        timeout: 100,         # Timeout for non-async searches (milliseconds)
        async: false,          # Use async for searching
        async_timeout: 200,  # Async timeout in milliseconds
        async_minlines: 200, # Minimum lines to enable async search
        highlight: true,      # Disable menu highlighting (for performance)
        trigger: 't',         # 't' for tab/s-tab, 'n' for ctrl-n/p and up/down arrows
        reverse: false,       # Upside-down menu
        prefixlen: 1,         # The minimum prefix length before the completion menu is displayed
    },
    cmd: {
        enable: true,      # Enable/disable the completion functionality
        pum: false,         # 'true' for stacked popup menu, 'false' for flat
        exclude: [],       # List of (regex) patterns to exclude from completion
        onspace: ['colo\%[rscheme]', 'b\%[uffer]', 'sy\%[ntax]'],
        # Complete after the space after the command
        alwayson: true,    # If 'false', press <tab> to open the popup menu manually
        popupattrs: {},    # Attributes for configuring the popup window
        wildignore: true,  # Exclude wildignore patterns during file completion
        addons: true,      # Enable additional completion addons (like fuzzy file finder)
        trigger: 't',      # 't' for tab/s-tab, 'n' for ctrl-n/p and up/down arrows
        reverse: false,    # Upside-down menu
        auto_first: false, # Automatically select first item from menu if none selected
        prefixlen: 1,      # The minimum prefix length before the completion menu is displayed
        complete_sg: true, # Complete :s// :g//
    },
    keymap: {
        page_up: ["\<M-k>"],
        page_down: ["\<M-j>"],
        hide: "\<C-l>",     # Hide popup window
        dismiss: "",  # Dismiss auto-completion
        send_to_qflist: "",    # Add to quickfix list
        send_to_arglist: "",   # Add to arglist
        send_to_clipboard: "", # Add to system clipboard ('+' register)
        split_open: "",
        vsplit_open: "",
        tab_open: "",
    }
}
autocmd VimEnter * g:VimSuggestSetOptions(vimsuggestOpt)

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

