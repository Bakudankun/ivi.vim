let s:save_cpo = &cpo
set cpo&vim


function ivi#open(count, mods) abort
  let ivi_winnr = bufwinnr('^' . g:ivi_bufname . '$')
  if ivi_winnr < 0
    let winheight = a:count ? a:count : get(g:, 'ivi_winheight', '')

    execute a:mods 'noswapfile belowright' winheight . 'split' g:ivi_bufname
    call s:init_buffer()
  else
    execute a:mods ivi_winnr . 'wincmd w'
  endif

  startinsert
endfunction


function s:init_buffer() abort
  set bufhidden=wipe
  set buftype=prompt
  set filetype=vim

  call prompt_setprompt(bufnr(''), ':')
  call prompt_setcallback(bufnr(''), function('s:callback'))
  call prompt_setinterrupt(bufnr(''), function('s:interrupt'))
endfunction


function s:callback(command) abort
  let save_winid = win_getid()
  wincmd p

  redir => output
  call s:run_command(a:command)
  redir END

  call win_gotoid(save_winid)
  call append(line('$') - 1, split(output, "\n"))

  set nomodified
endfunction


function s:interrupt() abort
  stopinsert
  quit!
endfunction


function s:run_command(command) abort
  silent! execute a:command
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sts=2 sw=2
