"set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
"
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = ''
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  silent execute '!C:\Vim\vim72\diff -a ' . opt . '"' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
"endfunction

source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction



"set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,chinese
"set fileencodings=chinese,ucs-bom,utf-8
"set ambiwidth=double

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"
" colorscheme
"
color midnight2

set fileformat=unix
set number
set hls
set is
set ignorecase

set guifont=Consolas:h10

"
" remove toolbar
"
set guioptions-=T

set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

set laststatus=2

"
" temp and swap file backup path: d:/temp
"
set backupdir=e:/temp

set dir=e:/temp

"
" help from he
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

"
" for taglists
"
set tags+=../tags,../../tags,../../../tags,../../../../tags

"
" for taglist
"
filetype on
let Tlist_Ctags_Cmd='c:\\windows\ctags.exe'

nnoremap <silent> <F8> :Tlist<CR>
nnoremap <silent> <F7> :TlistUpdate<CR>
nnoremap <silent> <F9> :TlistSync<CR>

"
" never resize the window
"
let Tlist_Inc_Winwidth = 0

"
" for Comment
"
"let g:EnhCommentifyUseAltKeys = 'yes'
"let g:EnhCommentifyTraditionalMode = 'N'
"

"set guifont=Courier_New:h11

"
" for plugin project.vim
"
" mapping <F12> : open project
"
let g:proj_flags="imstg"

set csprg=e:/windows/cscope

set formatoptions+=mM

nnoremap <F5> "=strftime("%c")<CR>P

" ÔÚä¯ÀÀÆ÷Ô¤ÀÀ for win32
function! ViewInBrowser(name)
    let file = expand("%:p")
    exec ":update " . file
    let l:browsers = {
        \"cr":"D:/WebDevelopment/Browser/Chrome/Chrome.exe",
        \"ff":"D:/WebDevelopment/Browser/Firefox/Firefox.exe",
        \"op":"D:/WebDevelopment/Browser/Opera/opera.exe",
        \"ie":"C:/progra~1/intern~1/iexplore.exe",
        \"ie6":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie6",
        \"ie7":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie7",
        \"ie8":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie8",
        \"ie9":"D:/WebDevelopment/Browser/IETester/IETester.exe -ie9",
        \"iea":"D:/WebDevelopment/Browser/IETester/IETester.exe -all"
    \}
    let htdocs='E:\\@apmxe\\htdocs\\'
    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
    if strpos == -1
       exec ":silent !start ". l:browsers[a:name] ." file://" . file
    else
        let file=substitute(file, htdocs, "http://127.0.0.1:8090/", "g")
        let file=substitute(file, '\\', '/', "g")
        exec ":silent !start ". l:browsers[a:name] file
    endif
endfunction


function Mkdp()
  write
  let file   = expand( "%:p" )
  let mkd_file = file . ".html"
  let markdown="e:/cygwin/bin/perl e:/workspace/markdown/Markdown_1.0.1/Markdown_1.0.1/Markdown.pl "
  "exec ":silent !start " . markdown . file . " > " . mkd_file
  exec ":silent ! " . markdown . file . " > " . mkd_file
  let browser="C:/progra~1/intern~1/iexplore.exe"
  exec ":silent !start ". browser . " file://" . mkd_file
endfunction
":map :mm :call Mkdp()<CR>
nnoremap <leader>p :call Mkdp()<CR>


"""
" when format line using 'gq'. Each line is 70 chars. 2008.05.19
"""""
"set textwidth=70

"" begin of folder balloon tips. 2007.11.14
"function! FoldSpellBalloon()
"	let foldStart = foldclosed(v:beval_lnum )
"	let foldEnd = foldclosedend(v:beval_lnum)
"	let lines = []
"	" Detect if we are in a fold
"	if foldStart < 0
"		" Detect if we are on a misspelled word
"		let lines = spellsuggest( spellbadword(v:beval_text)[ 0 ], 5, 0 )
"	else
"		" we are in a fold
"		let numLines = foldEnd - foldStart + 1
"		" if we have too many lines in fold, show only the first 14
"		" and the last 14 lines
"		if ( numLines > 31 )
"			let lines = getline( foldStart, foldStart + 14 )
"			let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
"			let lines += getline( foldEnd - 14, foldEnd )
"		else
"			"less than 30 lines, lets show all of them
"			let lines = getline( foldStart, foldEnd )
"		endif
"	endif
"	" return result
"	return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
"endfunction
"set balloonexpr=FoldSpellBalloon()
"set ballooneval
"" end of folder balloon tips. 2007.11.14

"set foldmethod=manual
"function! Num2S(num, len)
"    let filler = "                                                            "
"    let text = '' . a:num
"    return strpart(filler, 1, a:len - strlen(text)) . text
"endfunction
"
"function! FoldText()
"    let sub = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=', '', 'g')
"    let diff = v:foldend - v:foldstart + 1
"    return  '+' . v:folddashes . '[' . Num2S(diff,3) . ']' . sub
"endfunction
"
"set foldtext='FoldText()'

"2011-2-10 17:17:57 for markdown 
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
"    if getline(v:lnum) =~ '^#### .*$'
"        return ">4"
"    endif
"    if getline(v:lnum) =~ '^##### .*$'
"        return ">5"
"    endif
"    if getline(v:lnum) =~ '^###### .*$'
"        return ">6"
"    endif
    return "=" 
endfunction
au BufEnter *.txt setlocal foldexpr=MarkdownLevel()  
au BufEnter *.txt setlocal foldmethod=expr     
