" File: AddCppClass.vim
" Version: 0.1.2
" Author: Hong Xu(xuphys AT gmail DOT com)
" Last Change: 3 May 2010
" Description: this plugin aims to let users add cpp classes conveniently  
" License: You can redistribute this plugin and / or modify it under the terms 
"          of the GNU General Public License as published by the Free Software 
"          Foundation; either version 2, or any later version. 

if v:version < 700
    finish
endif

" check whether this script is already loaded
if exists("g:loaded_AddCppClass")
    finish
endif
let g:loaded_AddCppClass = 1

let s:saved_cpo = &cpo
set cpo&vim

" varibles
let g:AddCppClass_version = 1 "version 

"functions
function s:IsClassNameLegal(classname)
    return a:classname =~ "^[a-zA-Z_][a-zA-Z0-9_]*$"
endfunction

" get file name according to its path
function s:GetFileNameFromPath(filepath)
    let l:lastseperator = max([strridx(a:filepath,"/"),strridx(a:filepath,"\\")]) + 1
    return strpart(a:filepath,l:lastseperator)
endfunction

function s:Main()
    " get the class' name
    let l:classname = input("Please input your new class name:")
    if l:classname =~ "^ *$" "if class name is empty, return directly 
        return
    endif
    while !s:IsClassNameLegal(l:classname) "if the class name is illegal
        let l:classname = input("Your class name is illegal. Please input another one:")
    endwhile

    " get father classes
    let l:fatherclasses = []
    while 1
        let l:onefatherclassname=input("Please input a father class(Press enter directly if you want to skip):")
        if l:onefatherclassname == ""
            break
        endif
        if !s:IsClassNameLegal(l:onefatherclassname)
            echo "Your class name is illegal."
            continue
        endif

        let l:choice = inputlist(['Select the mode to derive:','1. public','2. protected','3. private','4. virtual public','5. virtual protected','6. virtual private'])

        echo "\n"

        if l:choice == 1
            call add(l:fatherclasses,'public '.l:onefatherclassname)
        elseif l:choice == 2
            call add(l:fatherclasses,'protected '.l:onefatherclassname)
        elseif l:choice == 3
            call add(l:fatherclasses,'private '.l:onefatherclassname)
        elseif l:choice == 4
            call add(l:fatherclasses,'virtual public '.l:onefatherclassname)
        elseif l:choice == 5
            call add(l:fatherclasses,'virtual protected '.l:onefatherclassname)
        elseif l:choice == 6
            call add(l:fatherclasses,'virtual private '.l:onefatherclassname)
        else
            continue
        endif

        if 1 == inputlist(["more father classes?",'1.yes','2.no'])
            continue
        else
            break
        endif
    endwhile

    echo "\n"

    " ask for implementation file name
	"let s:filelist = split(l:classname,'\u')
	"let s:filename = join(s:filelist,'_')
	let s:str = l:classname
	let s:filename = ''
    let out = ''
    for ix in range(strlen(s:str))
		if (char2nr(s:str[ix]) <= 96) && (char2nr(s:str[ix]) >= 57) && ix > 0
			if !((char2nr(s:str[ix-1]) <= 96) && (char2nr(s:str[ix-1]) >= 57))
				let out = out . '_'
			endif
		endif
		if (char2nr(s:str[ix]) <= 122 && char2nr(s:str[ix]) >= 97) || (char2nr(s:str[ix]) <= 90 && char2nr(s:str[ix]) >= 48)
			let out = out . tolower(s:str[ix])
		endif
    endfor
	if !empty(out)
		let s:filename = out
	"tolower(s:filename)

    let l:implementfilename = ""
    while 1
        let l:implementfilename = input("Please input the implementation file's name:","./".s:filename.".cpp")
        if getftype(l:implementfilename) == "file"
            if 1 == inputlist(["File \"".l:implementfilename."\" already exists. this action will clear the file. Do you still want to continue?",'1.yes','2.no'])
                echo "\n"
                if !filewritable(l:implementfilename)
                    echo "File \"".l:implementfilename."\" is not writable. Please choose another file.\n"
                    continue
                endif
                break
            else
                continue
            endif
        elseif getftype(l:implementfilename) == "dir"
            echo "File \"".l:implementfilename."\" is a directory. Please choose another file.\n"
            continue
        elseif getftype(l:implementfilename) != ""
            echo "File \"".l:implementfilename."\" is not writable. Please choose another file.\n"
            continue
        endif
        break
    endwhile

    echo "\n"

	if empty(l:implementfilename)
		echo "Failed, filename is empty.\n"
		return
	endif

    "ask for header file name
    let l:headerfilename = ""
    while 1
        let l:headerfilename = input("Please input the header file's name:","./".s:filename.".h")
        if getftype(l:headerfilename) == "file"
            if 1 == inputlist(["File \"".l:headerfilename."\" already exists, this action will clear the file. Do you still want to continue?",'1.yes','2.no'])
                echo "\n"
                if !filewritable(l:headerfilename)
                    echo "File \"".l:headerfilename."\" is not writable. Please choose another file.\n"
                    continue
                endif
                break
            else
                continue
            endif
        elseif getftype(l:headerfilename) == "dir"
            echo "File \"".l:headerfilename."\" is a directory. Please choose another file.\n"
            continue
        elseif getftype(l:headerfilename) != ""
            echo "File \"".l:headerfilename."\" is not writable. Please choose another file.\n"
            continue
        endif
        break
    endwhile

    echo "\n"

	if empty(l:implementfilename) || empty(l:headerfilename)
		echo "Failed, filename is empty.\n"
		return
	endif

    echo "Generating code...\n"

    "write header file
    let l:headerfilecontent = []
    let l:string = s:GetFileNameFromPath(l:headerfilename)
    let l:string = toupper(l:string)
    let l:string = substitute(l:string,"[^a-zA-Z_0-9]","_","g")
    if strpart(l:string,0,0) =~ "[0-9]"
        let l:string = "_".l:string
    endif

	let s:def_date = strftime("%y%m%d")
	let s:make_name = "__".l:string."_".s:def_date."__"
    call add(l:headerfilecontent,"#ifndef ".s:make_name)
    call add(l:headerfilecontent,"#define ".s:make_name)
	if exists("g:DoxygenToolkit_authorName")
		call add(l:headerfilecontent,"/**")
		call add(l:headerfilecontent," * author: ". g:DoxygenToolkit_authorName)
		if exists("g:DoxygenToolkit_authorEmail")
		call add(l:headerfilecontent," * email: ". g:DoxygenToolkit_authorEmail)
		endif
 
		let s:date = strftime("%Y/%m/%d")
		call add(l:headerfilecontent," * date: ". s:date)
		call add(l:headerfilecontent," */")
	endif
    call add(l:headerfilecontent,"")
    let l:string = "class ".l:classname
    if !empty(l:fatherclasses)
        let l:string = l:string." : "
    endif
    for n in l:fatherclasses
        let l:string = l:string.n
        let l:string = l:string.", "
    endfor
    if !empty(l:fatherclasses)
        let l:string = strpart(l:string,0,strlen(l:string)-2)
    endif
    call add(l:headerfilecontent,l:string)
    call add(l:headerfilecontent,"{")
    call add(l:headerfilecontent,"public:")
    call add(l:headerfilecontent,"\t//constructor and destructor")
    call add(l:headerfilecontent,"\t".l:classname."(void);")
    call add(l:headerfilecontent,"\t~".l:classname."(void);")
    call add(l:headerfilecontent,"};")
    call add(l:headerfilecontent,"")
    call add(l:headerfilecontent,"#endif /* ".s:make_name." */")
    call add(l:headerfilecontent,"")
    call writefile(l:headerfilecontent,l:headerfilename)

    "write implementation file
    let l:implementfilecontent = []
    let l:string = s:GetFileNameFromPath(l:headerfilename)
	if exists("g:DoxygenToolkit_authorName")
		call add(l:implementfilecontent,"/**")
		call add(l:implementfilecontent," * author: ". g:DoxygenToolkit_authorName)
		if exists("g:DoxygenToolkit_authorEmail")
		call add(l:implementfilecontent," * email: ". g:DoxygenToolkit_authorEmail)
		endif
 
		let s:date = strftime("%Y/%m/%d")
		call add(l:implementfilecontent," * date: ". s:date)
		call add(l:implementfilecontent," */")
	endif
    call add(l:implementfilecontent,"#include \"".l:string."\"")
    call add(l:implementfilecontent,"")
    call add(l:implementfilecontent,"//constructor")
    call add(l:implementfilecontent,l:classname."::".l:classname."(void)")
    call add(l:implementfilecontent,"{")
    call add(l:implementfilecontent,"}")
    call add(l:implementfilecontent,"")
    call add(l:implementfilecontent,"//destructor")
    call add(l:implementfilecontent,l:classname."::~".l:classname."(void)")
    call add(l:implementfilecontent,"{")
    call add(l:implementfilecontent,"}")
    call add(l:implementfilecontent,"")
    call writefile(l:implementfilecontent,l:implementfilename)

    echo "Your new class has been added now."
    return
endfunction

command AddCppClass call s:Main()

let &cpo = s:saved_cpo
