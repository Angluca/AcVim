vim9script
# ---- 通用小工具 ----
def g:AcSetMap(target: string, combo: string)
  for mode in ['n', 'x']
    if !hasmapto(target, mode)
      execute $"{mode}map {combo} {target}"
    endif
  endfor
enddef

def g:AcMakeDir(ds: string)
  if finddir(ds) == ''
    mkdir(ds, 'p')
  endif
enddef

def g:AcIsOK(yn: number, emsg: string, ymsg: string, nmsg: string): number
  echohl WarningMsg
  if emsg != ''
    echo emsg
  endif
  var ret = yn
  var rmsg = nmsg
  if yn == -1
    ret = getchar() == char2nr('Y') ? 1 : 0
  endif
  if ret > 0
    rmsg = ymsg
    echohl Question
  endif
  if rmsg != ''
    redraw
    echo rmsg
  endif
  echohl None
  return ret
enddef

def g:AcClsUndo()
  if g:AcIsOK(-1, 'Do you want clear all undo? [Y]: ', 'Clear finish', 'Cancel') != 0
    var ul_bak = &undolevels
    var md_bak = &modified
    &undolevels = -1
    execute "normal I \<BS>\<Esc>"
    &undolevels = ul_bak
    &modified = md_bak
    g:AcIsOK(1, '', 'Clear finish', '')
  endif
enddef

# ---- dict / tags 文件处理 ----
def g:Fdict()
  var cmds =<< trim END
    :%s/^.*LICENSE.*$\n//ge
    :%s/^.\{,1}\s.*$\n//ge
    :%s/^[0-9.^]\+\k*\s..*$\n//ge
    :%s/.*\/^\s*\\\/\\\/.*$\n//ge
    :g/^\([0-9A-Za-z_.:]\+\)\s.*$\n\1$/d
    :%s/^\([0-9A-Za-z_.:]\+\)\s.*/\1/ge
    :g/^\W\+.*$/d
    :%sort u
    :g/^.\{,1}\s*$/d
    :silent w
  END
  for cmd in cmds
    execute cmd
  endfor
enddef

def g:Ftags(rd: string = '', only_add_path: number = 0)
  # 正则里全是反斜杠，用单引号拼接，不要用 $'' 插值
  if rd != ''
    execute ':%s/\t\(.*\.\w\+\)\t/\t' .. rd .. '\/\1\t/ge'
  else
    var p = input('path: ')
    if p != ''
      execute ':%s/\v^.*\s*\/?tests?\/.*$\n//ge'
      execute ':%s/\t\(.*\.\w\+\)\t/\t' .. p .. '\/\1\t/ge'
    endif
  endif
  if only_add_path != 0
    execute 'silent w'
    return
  endif
  var cmds =<< trim END
    :%s/\v^.*\sdither\s.*$\n//ge
    :%s/^.*LICENSE.*$\n//ge
    :%s/^.\{,1}\s.*$\n//ge
    :%s/^[0-9.^]\+\k*\s..*$\n//ge
    :g/^\(\k\+\t.*\.\k\+\t\).*$\n\1.*/d
    :g/^\~.*$/d
    :g/^!_.*$/d
    :g/^.\?\s*$/d
    :%s/^\w\{,1}\s\+.*$\n//ge
    :%s/^.*.md\t.*$\n//ge
    :%s/^.*.json\t.*$\n//ge
    :%s/^.*.txt\t.*$\n//ge
    :%s/\v^.*\/tests?\/.*$\n//ge
    :%s/.*\/^\s*\\\/\\\/.*$\n//ge
    :silent w
  END
  for cmd in cmds
    execute cmd
  endfor
enddef

nmap \-- :call g:Ftags('', 0)<cr>
nmap \-0 :call g:Fdict()<cr>

def g:GenTags(app: string = 'ctags', opt: string = '', f: string = '', path: string = '')
  execute $'silent !{app} {opt}'
  if f == ''
    return
  endif
  execute $'e ./{f}'
  g:Ftags(path, 1)
enddef

def g:GenCtags(opt: string = '', f: string = '', path: string = '')
  g:GenTags('ctags', $'--options={opt} -R -f {f}', f, path)
enddef

# ---- filetype / dict / tags 绑定 ----
def g:SetFt(fn: string, ft: string, bc: string = 'BufEnter')
  execute $"au {bc} {fn} setl ft={ft}"
enddef

def g:SetFtCmd(ft: string, cmd: string, bc: string = 'FileType')
  execute $"au {bc} {ft} {cmd}"
enddef

def g:SetDict(ft: string, dir: string, ...files: list<string>)
  var d = dir != '' ? dir .. '/' : $VIMDICT
  var opt = ''
  for file in files
    opt ..= d .. file .. ','
  endfor
  execute $"au FileType {ft} setl dict={opt}"
enddef

def g:SetTags(ft: string, dir: string, ...files: list<string>)
  var d = dir != '' ? dir .. '/' : $VIMDICT
  var opt = ''
  for file in files
    opt ..= d .. file .. ','
  endfor
  execute $"au FileType {ft} setl tags={opt}"
enddef

# ---- 杂项工具 ----
var vem = false
def g:ToggleVE()
  vem = !vem
  &ve = vem ? 'all' : ''
  echo vem ? 'virtual edit on' : 'virtual edit off'
enddef

def g:SwitchToBuf(filename: string)
  var wnr = bufwinnr(filename)
  if wnr != -1
    execute $"{wnr}wincmd w"
    return
  endif
  tabfirst
  for tabnr in range(1, tabpagenr('$'))
    wnr = bufwinnr(filename)
    if wnr != -1
      execute $"normal {tabnr}gt"
      execute $"{wnr}wincmd w"
      return
    endif
    tabnext
  endfor
  execute $"e {filename}"
enddef

def g:FmtOpt()
  var formats = ['unix', 'dos', 'mac']
  var dflt = index(formats, &ff) + 1
  if dflt == 0
    dflt = 1
  endif
  var n = confirm('Select format for writing the file',
        "&Unix\n&Dos\n&Mac\n&Cancel", dflt, 'Question')
  if n >= 1 && n <= 3
    execute $'set ff={formats[n - 1]}'
  endif
enddef

def g:Bclose()
  var cur = bufnr()
  if buflisted(bufnr('#'))
    buffer #
  else
    bnext
  endif
  if bufnr() == cur
    new
  endif
  if buflisted(cur)
    execute $'bdelete! {cur}'
  endif
enddef

def g:DelTWS(bb: number = 0)
  if bb != 0 && g:AcIsOK(-1, 'Clear all trailing space? [Y]: ', 'Clear finish', 'Cancel') == 0
    return
  endif
  execute 'normal mz'
  execute ':%s/\s\+\r\?$//ge'
  nohlsearch
  execute 'normal `z'
enddef

# ---- 按 filetype 注册构建命令 ----
def g:AcFtCmdRun(file: string, cmd: string)
  var root = fnamemodify(findfile(file, '.;'), ':h')
  if root != ''
    execute 'lcd ' .. root
    execute cmd
  endif
enddef

def g:AcFtCmd(ft: string, key: string, file: string, cmd: string, ...extra: list<string>)
  var body = $"call g:AcFtCmdRun({string(file)}, {string(cmd)})"
  for c in extra
    body ..= ' | ' .. c
  endfor
  execute $"au FileType {ft} com! -bang -nargs=* -complete=file {key} {body}"
enddef

# ---- 跳转 ----
def g:GotoRead(cmd: string)
  var bnr = bufnr()
  silent! execute cmd
  if bufnr() != bnr
    setlocal readonly nomodifiable
  endif
enddef
nnoremap <silent> <C-]> :<C-u>call g:GotoRead(((&ft == 'help') ? 'help ' : 'tag ') . expand('<cword>'))<cr>

g:smart_open_brackets  = '([{,":=<'
g:smart_close_brackets = ')]},":=>'
g:smart_brackets_pattern = '[()\[\]{}<>,=":]'

def g:SmartBracketJump(forward: number): string
  var line = getline('.')
  var text: string
  var steps: number
  if forward > 0
    text = strpart(line, col('.') - 1)
    var idx = match(text, g:smart_brackets_pattern)
    if idx == -1
      return "\<C-o>$"
    endif
    steps = idx + 1
    if stridx(g:smart_close_brackets, text[idx]) != -1 && idx + 1 < len(text)
      if stridx(g:smart_open_brackets, text[idx + 1]) != -1
        steps += 1
      endif
    endif
    return repeat("\<Right>", steps)
  endif
  text = strpart(line, 0, col('.') - 1)
  var matched = matchstr(text, '.*\zs' .. g:smart_brackets_pattern)
  if matched == ''
    return "\<C-o>^"
  endif
  var idx2 = strridx(text, matched)
  steps = col('.') - 1 - idx2
  if stridx(g:smart_open_brackets, matched) != -1 && idx2 > 0
    if stridx(g:smart_close_brackets, text[idx2 - 1]) != -1
      steps += 1
    endif
  endif
  return repeat("\<Left>", steps)
enddef
ino <expr> <M-n> g:SmartBracketJump(1)
ino <expr> <M-p> g:SmartBracketJump(0)

# ---- 仅保留交互使用的命令（<f-args> 自动加引号和空格）----
com! -nargs=+ AcSetMap call g:AcSetMap(<f-args>)
com! -nargs=1 AcMakeDir call g:AcMakeDir(<f-args>)
com! -nargs=+ AcIsOK call g:AcIsOK(<f-args>)
com! AcClsUndo call g:AcClsUndo()
com! Fdict call g:Fdict()
com! -nargs=? Ftags call g:Ftags(<f-args>)
com! -nargs=+ Maketags call g:GenTags(<f-args>)
com! -nargs=+ Mctags call g:GenCtags(<f-args>)
com! -nargs=+ SetFt call g:SetFt(<f-args>)
com! -nargs=+ SetFtCmd call g:SetFtCmd(<f-args>)
com! -nargs=+ SetDict call g:SetDict(<f-args>)
com! -nargs=+ SetTags call g:SetTags(<f-args>)
com! ToggleVE call g:ToggleVE()
com! -nargs=1 SwitchToBuf call g:SwitchToBuf(<f-args>)
com! FmtOpt call g:FmtOpt()
com! Bclose call g:Bclose()
com! -nargs=? DelTWS call g:DelTWS(<f-args>)
com! -nargs=+ GotoRead call g:GotoRead(<f-args>)
com! -nargs=+ AcFtCmd call g:AcFtCmd(<f-args>)

