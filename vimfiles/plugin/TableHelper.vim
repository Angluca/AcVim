" File:        TableHelper.vim
" By:          Salman Halim (salmanhalim@gmail.com)
" Description: Plugin to easily align text in columns (to make tables).
"
" Version 2.0:
"
" When calling Gettabstopsfromcurrentline, the last column size is set to the larger of the value of g:TableHelper_lastColumnSize or the length of the text in
" the last column being measured. The very last column of text isn't truncated (unless lines with more columns than measured show up), but this value is used
" when generating separator lines.
"
" Added some commands:
"
" Aligntable: given a range of lines (visually selected, for example), will automatically figure out the optimum layout. Takes optional arguments: the column
" alignments (see Setcolumnalignments) and the amount by which the table should be indented. (If not specified, all alignments take the defaults as specified
" for Setcolumnalignments and the indent becomes the indentation of the first line in the range).
"
" To specify just an indent, pass in 'l' for the first argument (that's the default and all values get left-aligned anyway).

" As an example, the following table
"
" First name            Last name               Age
" ------  -----  -----
" John   Smith   28
" Jane             Doe          32
"
" can be selected visually and Aligntable executed to get (with a default column margin value of 2):
"
" First name  Last name  Age
" ------      -----      -----
" John        Smith      28
" Jane        Doe        32
"
" Executing with a column margin of 10, on the other hand, gives:
"
" First name          Last name          Age
" ------              -----              -----
" John                Smith              28
" Jane                Doe                32
"
" The column positions used are stored (clobbering any previous calls to Gettabstopsfromcurrentline) so new lines may be added to this table and reformatted
" quickly using the standard reformatting hotkey.
"
" Addseparatorline: adds a separator line just below the current cursor line. If the tab stops are from this line
"
" First name          Last name          Age
"
" then executing "Addseparatorline" with the cursor on the line itself gives

" Addseparatorline
" ------------------  -----------------  ----------
"
" The space between separators is determined by g:TableHelper_columnMargin.
"
" The command takes these arguments, all optional (with default values):
"
" Addseparatorline [continuous=0] [separator characters=g:TableHelper_separatorCharacters]
"
" The first argument is whether to generate a continuous line (defaults to 0) or one with breaks at the column margins:
"
" Addseparatorline 0 -=
" -=-=-=-=-=-=-=-=-=  -=-=-=-=-=-=-=-=-  -=-=-=-=-=
"
" Addseparatorline 1 -=+
" -=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-=+-
"
" And the second determines the separators to use for this line.
"
" Addseparatorline 1 :-
" :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
"
" Setcolumnalignments: Takes a string consisting of an arbitrary number of 'l' (left), 'c' (center) and 'r' (right); for example, 'llrlc'. When reformatting a
" line or calling Aligntable, this value is taken into consideration for how to align the value in a particular column. Thus, 'llrlc' means that the first
" two columns will be left-aligned, the third will be right-aligned, and then left and, finally, the last column will be centered in the allocated space.
"
" If the table contains more columns than specified in the alignment, the remaining columns are all left-aligned ('l'). Column values that are too long (doesn't
" happen when Aligntable is called unless the lines are added after the fact) end up being left-aligned (or truncated, in which case they fill up the entire
" column and alignment doesn't enter into it).
"
" The alignments are stored on a per-buffer basis (just like the table column stops).
"
" New options:
"
" g:TableHelper_lastColumnSize (default 10): used for adding separator lines; specifies the minimum length for the last column
"
" g:TableHelper_separatorCharacters (default '-'): the character string that the separator comprises; gets repeated and truncated as necessary and starts over
" every time there is a column break (repeats continuously if no break is chosen)
"
" Version 1.0:
"
" Initial version.
"
" This plugin helps with aligning text in columns, making the creation of tables easier. The process is simple:
"
" 1. Manually lay out one line of the table (the header, for example) and execute the command Gettabstopsfromcurrentline (there is a hotkey, in case you do this
" often) to have it parse the line and save the column definitions (per buffer).
"
" 2. Go to any other lines that are supposed to be in the table and either hit the hotkey on them one by one or visually select a range and hit the hotkey and
" they will all get realigned to match the header row.
"
" Caveat: these example may look horribly aligned if viewed with a proportional font.
"
" For example, given these three rows of text:
"
" First name            Last name               Age
" ------  -----  -----
" John   Smith   28
" Jane             Doe          32
"
" If the first line is the one parsed for the columns, hitting the hotkey on the remaining lines yields:
"
" First name            Last name               Age
" ------                -----                   -----
" John                  Smith                   28
" Jane                  Doe                     32
"
" If you parse the last line instead you get this:
"
" First name       Last name    Age
" ------           -----        -----
" John             Smith        28
" Jane             Doe          32
"
" If you have the repeat.vim autoload plugin installed, the reformatting is repeatable on other lines.
"
" Requirements: the column text has to be separated by at least 2 spaces, both for the header line and for each line that is to be reformatted. For example:
"
" First name  Last name  Age
"
" Defines three columns, as does:
"
" First name          Last name            Age
"
" Options:
"
" g:TableHelper_truncateLongEntries (default 0): occasionally, you might have an entry in a table that is too long (say, you allocated 10 spaces for a column in
" the header but the text is actually 12 characters). This option determines how that is handled:
"
" - If 1, the entry gets truncated to fit. You will lose data, but the table will still line up (small price to pay!)
"
" - If 0, the entry is put in as is and allowed to comprise as many columns as needed. The rest of the text is simply aligned to the next column. You will
"   retain all your data, but will lose formatting.
"
" In practice, you should probably leave this value at 0. If you see misalignments, adjust your header row, recalculate the column stops, visually select your
" table and hit the hotkey and the whole thing will be realigned. If you start truncating fields, your only recourse will be the undo (u) key. (I only put this
" option in at all because it was fairly easy to implement the truncation!)
"
" g:TableHelper_columnMargin (default 2): how much space must there be between the end of one column's text and the start of the next before it's considered too
" long a column. Typically, you have to have some space between adjacent columns (or else, how can you tell where one column ends and the next begins). For
" example, if your header row and first row of data look like this:
"
" FName    LName  Age
" Jonathan  Smythe  28
"
" During reformat, the first column will be considered too long because there wouldn't be 2 spaces between Jonathan and Smythe (assuming
" g:TableHelper_columnMargin is set to 2--you can set it higher to get more space between columns). Thus, if you have truncation enabled
" (g:TableHelper_truncateLongEntries is 1), you'll get this:
"
" FName    LName  Age
" Jonatha  Smyth  28
"
" As it happens, the last name was too long, also. If you don't have truncation enabled, you get this:
"
" FName    LName  Age
" Jonathan        Smythe  28
"
" "Smythe" simply gets pushed under the next available column and then, since the number of header columns runs out, subsequent columns of text are simply
" placed as is, separated by g:TableHelper_columnMargin spaces.
"
" This plugin requires at least two spaces between columns to be able to recognize them as distinct columns, so a value less than 2, while supported, will
" seriously jeopardize any attempts to reformat the table as all the text will run together (try setting it to 0...). If someone complains, I can force 2 as the
" minimum.
"
" If you have my getVar.vim, then you can set these options on a per window, buffer or tab basis, also. (Otherwise, only on a global basis).
"
" Commands:
"
" Gettabstopsfromcurrentline: parses the current line for columns; probably best to call this from your header line, though you could also call it from the
" longest line in your table (and then use the alignment hotkey to have the header conform to this, also).
"
" Retabline: Reformats the specified lines (visually selected or the current line) so they conform to the previously specified header line.
"
" Showtabstops: Displays the list of tab stops currently defined, if any.
"
" Mappings:
"
" <Plug>TableHelper_Gettabstopsfromcurrentline: executes Gettabstopsfromcurrentline (defaults to <leader><c-t>)
"
" <Plug>TableHelper_Retabline: executes Retabline (defaults to <c-t>). May be called again after changing the truncation or column margin options to change the
" alignment of already formatted lines.
"
" The default hotkeys may be overridden in your vimrc.
"
" Tip: if you call Gettabstopsfromcurrentline on an empty line, you get no column definitions; then, when you try to reformat a line, it just ends up having the
" columns of text displayed in their entirety, separated by g:TableHelper_columnMargin spaces. For example, if g:TableHelper_columnMargin is 5, this line
"
" Jonathan                    Smythe  28
"
" becomes
"
" Jonathan     Smythe     28
"
" This might be useful for first laying out the longest line in the table, calling Gettabstopsfromcurrentline on it and then reformatting the entire table based
" on those column markers:
"
" FName        LName      Age
" -----        -----      ---
" Jonathan     Smythe     28
" Jon          Smith      32
"
" TODO: If there is interest, I could write a command to lay out a line with those spaces, ignoring column specifications to make it easier to lay a table out.

if ( exists( "g:TableHelper_loaded" ) )
  finish
endif

let g:TableHelper_loaded = 1

if ( !exists( "g:TableHelper_columnMargin" ) )
  let g:TableHelper_columnMargin = 2
endif

if ( !exists( "g:TableHelper_truncateLongEntries" ) )
  let g:TableHelper_truncateLongEntries = 0
endif

if ( !exists( "g:TableHelper_lastColumnSize" ) )
  let g:TableHelper_lastColumnSize = 10
endif

if ( !exists( "g:TableHelper_separatorCharacters" ) )
  let g:TableHelper_separatorCharacters = '-'
endif

function! GetColumnMargin()
  " If the override exists, use that instead of any other value.
  return exists( "b:TableHelper_overrideColumnMargin" ) ? b:TableHelper_overrideColumnMargin : RetrieveVariable( "TableHelper_columnMargin" )
endfunction

" Uses GetVar if it's available.
function! RetrieveVariable( variable )
  let result = g:{a:variable}

  try
    let result = GetVar#GetVar( a:variable, result )
  catch
  endtry

  return result
endfunction

" Initially, at least, the values should be l, c and r.
function! GetColumnAlignment( index )
  let alignments =  exists( "b:TableHelper_columnAlignments" ) ? b:TableHelper_columnAlignments : ''

  return a:index < strlen( alignments ) ? alignments[ a:index ] : 'l'
endfunction

function! GetTabStopsFromLine( lineNumber )
  let line = getline( a:lineNumber )

  let b:TableHelper_columnStops = []
  let index                     = matchend( line, '\S', 0 )

  while ( index >= 0 )
    let b:TableHelper_columnStops += [ index ]

    let index = matchend( line, '\s\{2,}\S', index )
  endwhile

  let b:TableHelper_columnStops += [ b:TableHelper_columnStops[ -1 ] + max( [ len( line ) - b:TableHelper_columnStops[ -1 ], RetrieveVariable( "TableHelper_lastColumnSize" ) - 1 ] ) + GetColumnMargin() + 1 ]
endfunction

function! RetabLine( startLine, endLine )
  if ( !exists( "b:TableHelper_columnStops" ) )
    echoerr "No tab stops have been defined. Please Gettabstopsfromcurrentline on the header line first."

    return
  endif

  let columnMargin        = GetColumnMargin()
  let truncateLongEntries = RetrieveVariable( "TableHelper_truncateLongEntries" )

  " Used to execute undojoin commands before setting lines so the entire alignment can be undone with one undo.
  let atLeastOneChange  = 0

  let initialWhitespace = len( b:TableHelper_columnStops ) > 0 ? repeat( ' ', b:TableHelper_columnStops[ 0 ] - 1 ) : ''
  let lineNumber        = a:startLine

  while ( lineNumber <= a:endLine )
    let line         = getline( lineNumber )
    let marginSpaces = repeat( ' ', columnMargin )
    let tokens       = split( line, '\s\{2,}' )
    let numTokens    = len( tokens )

    let result = ''

    let result .= initialWhitespace

    let tokenCounter   = 0
    let columnCounter  = 0
    let originalColumn = -1

    while ( tokenCounter < numTokens )
      let token = tokens[ tokenCounter ]

      let tooLong = 0

      " If this isn't the last token and it isn't the last defined column and the new text is too long to fit in the current column width...
      if ( ( tokenCounter < ( numTokens - 1 ) ) && ( columnCounter < len( b:TableHelper_columnStops ) - 1 ) && ( ( strlen( result ) + strlen( token ) ) >= ( b:TableHelper_columnStops[ columnCounter + 1 ] - columnMargin ) ) )
        let tooLong = 1
      endif

      if ( tooLong )
        if ( truncateLongEntries == 1 )
          let result .= token

          " Long entries get truncated
          let result  = strpart( result, 0, b:TableHelper_columnStops[ columnCounter + 1 ] - columnMargin - 1 )
          let result .= marginSpaces

          let columnCounter += 1
        else
          " Long entries are put in, forcing the column count to keep going
          if ( originalColumn < 0 )
            let originalColumn = columnCounter
          endif

          let columnCounter += 1
          let tokenCounter  -= 1
        endif
      else
        if ( columnCounter < ( len( b:TableHelper_columnStops ) - 1 ) )
          " Not too long, but we have more columns to consider, so have to pad the value with spaces to line up the next value correctly.
          let numSpaces = b:TableHelper_columnStops[ columnCounter + 1 ] - strlen( token ) - b:TableHelper_columnStops[ originalColumn >= 0 ? originalColumn : columnCounter ] - columnMargin

          " If the token was too long, it is always left aligned; otherwise, we look it up.
          let alignment = originalColumn >= 0 ? 'l' : GetColumnAlignment( tokenCounter )

          if ( alignment == 'l')
            let result .= token . repeat( ' ', numSpaces )
          elseif ( alignment == 'r' )
            let result .= repeat( ' ', numSpaces ) . token
          elseif ( alignment == 'c' )
            let spacesBefore = numSpaces / 2
            let spacesAfter  = spacesBefore * 2 == numSpaces ? spacesBefore : spacesBefore + 1

            let result .= repeat( ' ', spacesBefore ) . token . repeat( ' ', spacesAfter )
          endif

          let result .= marginSpaces

          let originalColumn = -1
        elseif ( tokenCounter < ( numTokens - 1 ) )
          " We have more tokens than defined column stops so just separate remaining columns with two spaces.
          let result .= token . marginSpaces
        endif

        let columnCounter += 1
      endif

      let tokenCounter += 1
    endwhile

    " If the line didn't change, no sense in having modification flags and the undo buffer changing.
    if ( result != line )
      if ( atLeastOneChange == 1 )
        undojoin
      else
        let atLeastOneChange = 1
      endif

      call setline( lineNumber, result )
    endif

    let lineNumber += 1
  endwhile
endfunction

function! AlignTable( line1, line2, ... )
  let b:TableHelper_columnAlignments = exists( "a:1" ) ? a:1 : 'l'

  let indent       = exists( "a:2" ) ? a:2 : indent( a:line1 )
  let columnMargin = GetColumnMargin()
  let numColumns   = 0
  let currentLine  = a:line1

  while ( currentLine <= a:line2 )
    let numColumns = max( [ numColumns, len( split( getline( currentLine ), '\s\{2,}' ) ) ] )

    let currentLine += 1
  endwhile

  let maxColumnStops = numColumns > 0 ? [ 1 ] : []

  let currentColumn = 1

  " One extra stop for the very last column.
  while ( currentColumn <= numColumns )
    let maxColumnStops += [ 1 + columnMargin ]

    let currentColumn += 1
  endwhile

  let currentLine = a:line1

  while ( currentLine <= a:line2 )
    let tokens    = split( getline( currentLine ), '\s\{2,}' )
    let numTokens = len( tokens )

    let currentColumnStops = []

    if ( numTokens > 0 )
      let currentColumnStops += [ 1 ]

      let tokenCounter = 1

      while ( tokenCounter <= numTokens )
        let currentColumnStops += [ len( tokens[ tokenCounter - 1 ] ) + columnMargin ]

        let tokenCounter += 1
      endwhile
    endif

    let columnIndex = 0

    while ( columnIndex < min( [ len( maxColumnStops ), len( currentColumnStops ) ] ) )
      let maxColumnStops[ columnIndex ] = max( [ maxColumnStops[ columnIndex ], currentColumnStops[ columnIndex ] ] )

      let columnIndex += 1
    endwhile

    let currentLine += 1
  endwhile

  let columnIndex = 1

  while ( columnIndex < len( maxColumnStops ) )
    let maxColumnStops[ columnIndex ] += maxColumnStops[ columnIndex - 1 ]

    let columnIndex += 1
  endwhile

  let columnIndex = 0

  while ( columnIndex < len( maxColumnStops ) )
    let maxColumnStops[ columnIndex ] += indent

    let columnIndex += 1
  endwhile

  let b:TableHelper_overrideColumnMargin = columnMargin
  let b:TableHelper_columnStops          = maxColumnStops

  call RetabLine( a:line1, a:line2 )

  unlet b:TableHelper_overrideColumnMargin
endfunction

function! AddSeparatorLine( ... )
  if ( !exists( "b:TableHelper_columnStops" ) )
    echoerr "No tab stops have been defined. Please execute Gettabstopsfromcurrentline on the header line first."

    return
  endif

  let continuous   = exists( "a:1" ) ? a:1 : 0
  let separator    = exists( "a:2" ) ? a:2 : RetrieveVariable( "TableHelper_separatorCharacters" )
  let columnMargin = GetColumnMargin()

  let result = ''

  if ( len( b:TableHelper_columnStops ) > 1 )
    " Initial whitespace
    let result .= repeat( ' ', b:TableHelper_columnStops[ 0 ] - 1 )

    if ( continuous )
      let numChars = b:TableHelper_columnStops[ -1 ] - columnMargin - 1

      " Make a bunch of copies of the separator and then truncate it to the desired length (in case the separator is more than one character).
      let result .= repeat( separator, numChars )

      let result = strpart( result, 0, numChars )
    else
      let columnMargin  = GetColumnMargin()
      let blanks        = repeat( ' ', columnMargin )
      let currentColumn = 1

      while ( currentColumn < len( b:TableHelper_columnStops ) )
        let numChars = b:TableHelper_columnStops[ currentColumn ] - b:TableHelper_columnStops[ currentColumn - 1 ] - columnMargin

        let result .= strpart( repeat( separator, numChars ), 0, numChars )

        if ( currentColumn < ( len( b:TableHelper_columnStops ) - 1 ) )
          let result .= blanks
        endif

        let currentColumn += 1
      endwhile
    endif
  endif

  put=result
endfunction

com! -range Retabline call RetabLine( <line1>, <line2> )
com! Gettabstopsfromcurrentline call GetTabStopsFromLine( '.' )
com! -range -nargs=* Aligntable call AlignTable( <line1>, <line2>, <f-args> )
com! Showtabstops echo exists( "b:TableHelper_columnStops" ) ? string( b:TableHelper_columnStops ) : '<No tab stops have been set up.>'
com! -nargs=* Addseparatorline call AddSeparatorLine( <f-args> )
com! -nargs=1 Setcolumnalignments let b:TableHelper_columnAlignments = <q-args>

if ( !hasmapto( '<Plug>TableHelper_Retabline', 'n' ) )
  nmap <silent> <c-t> <Plug>TableHelper_Retabline
endif

if ( !hasmapto( '<Plug>TableHelper_Retabline', 'v' ) )
  vmap <silent> <c-t> <Plug>TableHelper_Retabline
endif

if ( !hasmapto( '<Plug>TableHelper_Gettabstopsfromcurrentline', 'n' ) )
  nmap <silent> <leader><c-t> <Plug>TableHelper_Gettabstopsfromcurrentline
endif

" Since the mapping contains the LHS in the RHS (for repeat purposes), it's got to come after the hasmapto checks because Vim declares that such a mapping does
" actually exist.
noremap <Plug>TableHelper_Retabline :Retabline<cr>:silent! call repeat#set("\<Plug>TableHelper_Retabline")<cr>
nnoremap <Plug>TableHelper_Gettabstopsfromcurrentline :Gettabstopsfromcurrentline<cr>
