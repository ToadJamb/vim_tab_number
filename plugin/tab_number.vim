" File:        tab_number.vim
" Author:      Travis Herrick
" Version:     0.0.4
" Description: Display the tab number at the top of each tab.

function! TabNumberMyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let buffername = bufname(buflist[winnr - 1])
    let mod = getbufvar(buffername, '&mod')
    let tab_title = a:n . ':'

    if mod > 0
      let tab_title .= '+:'
    endif

    let tab_title .= pathshorten(buffername)

    return tab_title
endfunction

function! TabNumberMyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{TabNumberMyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

set tabline=%!TabNumberMyTabLine()
