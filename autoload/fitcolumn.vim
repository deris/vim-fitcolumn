" fitcolumn - 上下いずれかの行の特定の文字と同じ列まで指定した文字を入力する
" Version: 0.0.0
" Copyright (C) 2013 deris0126
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

let s:save_cpo = &cpo
set cpo&vim

" Public API {{{1

function! fitcolumn#fitabovecolumn(...) "{{{
  return s:InputRepeatedlyAdjacentColumn(1, a:000)
endfunction " }}}

function! fitcolumn#fitbelowcolumn(...) "{{{
  return s:InputRepeatedlyAdjacentColumn(0, a:000)
endfunction " }}}

"}}}

" Private {{{1

" 上(下)の行の特定の文字と同じ列まで指定文字で埋める
" TODO:support tab
" TODO:support specified char(検索する文字を正規表現で)
function! s:InputRepeatedlyAdjacentColumn(isabove, options) "{{{
  let arglen = len(a:options)
  if !(arglen == 0 || arglen == 1)
    return
  endif

  let options = {
    \ 'insertchar': '',
    \ 'searchchar': '',
    \ 'rightward': 0,
    \ }

  if arglen == 1
    if type(a:options[0]) != type({})
      return
    endif

    let options['insertchar'] = get(a:options[0], 'insertchar', '')
    let options['searchchar'] = get(a:options[0], 'searchchar', '')
    let options['rightward'] = get(a:options[0], 'rightward', 0)
  endif

  if !s:hasAdjacentLine(a:isabove)
    return ''
  endif

  let searchchar = s:inputCharWithDefault(
    \ a:isabove ? 'Input above char:' : 'Input below char:',
    \ options['searchchar'],
    \ )
  if searchchar == ''
    return ''
  endif

  let insertchar = s:inputCharWithDefault(
    \ 'Input insert char:',
    \ options['insertchar'],
    \ )
  if insertchar == ''
    return ''
  endif

  let lnum = line('.')
  let adjacentline = getline(
    \ a:isabove ? lnum - 1 : lnum + 1
    \ )

  let cnum = col('.')
  let idx = stridx(adjacentline, searchchar, cnum)
  if idx == -1
    return ''
  endif

  return repeat(insertchar, idx - cnum + 1 + options['rightward'])
endfunction "}}}

function! s:hasAdjacentLine(isabove) "{{{
  if a:isabove && line('.') == 0
    " 現在行が先頭行のとき、上の行はない
    return 0
  elseif !a:isabove && line('.') == line('$')
    " 現在行が終端行のとき、下の行はない
    return 0
  endif

  return 1
endfunction " }}}

function! s:inputCharWithDefault(prompt, default) "{{{
  if a:default != ''
    return a:default
  endif

  return s:inputChar(a:prompt)
endfunction " }}}

function! s:inputChar(prompt) "{{{
  redraw!
  echo a:prompt

  let char = getchar()
  redraw!
  if !s:isKeyboardAlnumOrSign(char)
    return ''
  endif

  return nr2char(char)
endfunction " }}}

function s:isKeyboardAlnumOrSign(char) " {{{
  " alphabet or sign or space or tab or CR
  if (a:char >= 32 && a:char <= 126) ||
    \ a:char == 9 ||
    \ a:char == 13
    return 1
  else
    return 0
  endif
endfunction " }}}

"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__ "{{{1
" vim: foldmethod=marker
