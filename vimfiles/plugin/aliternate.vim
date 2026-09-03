vim9script
# alternate.vim - switch between source and header files
# BSD-2 license applies, see LICENSE for licensing details.
# ---- 命令 ----
com! Alternate call g:AlternateCommand()
com! A call g:AlternateCommand()

# ---- 全局配置 ----
if !exists('g:AlternateAutoCreate')
    g:AlternateAutoCreate = false
endif

if !exists('g:AlternateCmdString')
    g:AlternateCmdString = 'e'
endif
if !exists('g:AlternateExtensionMappings')
    g:AlternateExtensionMappings = [
        {'.cpp': '.h', '.h': '.hpp', '.hpp': '.cpp'},
        {'.c': '.h', '.h': '.c'}
    ]
endif
if !exists('g:AlternatePaths')
    g:AlternatePaths = ['.', '../itf', '../include', '../src']
endif

# ---- 辅助函数 ----
def AlternateWarning(msg: string)
    echohl WarningMsg
    echomsg 'vim-alternate: ' .. msg
    echohl None
enddef

# ---- 核心函数 ----
def g:AlternateCommand()
    var filename: string = expand('%:t')
    var file_path: string = expand('%:p:h')
    var is_alternate_defined: bool = false
    var alternate_file_path: string = ''
    var longest_extension_length: number = 0
    var auto_create_file_path: string = ''

    for alternate_extension_mapping in g:AlternateExtensionMappings
        for extension in keys(alternate_extension_mapping)
            var extension_length: number = strlen(extension)
            if longest_extension_length < extension_length
                if strpart(filename, len(filename) - extension_length) == extension
                    var filename_without_extension: string = strpart(filename, 0, len(filename) - extension_length)
                    is_alternate_defined = true
                    var alternate_extension: string = alternate_extension_mapping[extension]

                    while !empty(alternate_extension) && alternate_extension != extension
                        for alternate_path in g:AlternatePaths
                            var candidate: string = file_path .. '/' .. alternate_path .. '/' .. filename_without_extension .. alternate_extension
                            if filereadable(candidate)
                                alternate_file_path = candidate
                                longest_extension_length = extension_length
                            elseif empty(auto_create_file_path)
                                auto_create_file_path = candidate
                            endif
                        endfor
                        alternate_extension = get(alternate_extension_mapping, alternate_extension, extension)
                    endwhile
                endif
            endif
        endfor
    endfor

    if g:AlternateAutoCreate && empty(alternate_file_path) && !empty(auto_create_file_path)
        var missing_dir: string = fnamemodify(auto_create_file_path, ':h:.')
        if !isdirectory(missing_dir)
            mkdir(missing_dir, 'p')
        endif
        var final_path: string = fnamemodify(auto_create_file_path, ':p:.')
        alternate_file_path = final_path
        writefile([], final_path)
    endif

    if !empty(alternate_file_path)
        # 修复命名冲突：使用新变量名 g:AlternateCmdString
        var cmd: string = g:AlternateCmdString .. ' ' .. fnamemodify(alternate_file_path, ':p:.')
        exe cmd
    elseif !is_alternate_defined
        var dot_pos: number = stridx(filename, '.')
        var ext: string = dot_pos >= 0 ? strpart(filename, dot_pos) : ''
        AlternateWarning('no alternate extension configured for ' .. ext)
    else
        AlternateWarning('no alternate file found')
    endif
enddef

