let s:save_cpo = &cpo
set cpo&vim


function ivi#open(count, mods) abort
  let ivi_winnr = bufwinnr('^' . g:ivi_config.bufname . '$')

  if ivi_winnr > 0
    execute a:mods ivi_winnr . 'wincmd w'
    return
  endif

  let winheight = a:count ? a:count :
        \ g:ivi_config.winheight > 0 ? g:ivi_config.winheight :
        \ ''

  execute a:mods 'noswapfile belowright' winheight 'split' g:ivi_config.bufname
  call s:init_buffer(winheight isnot# '')
  startinsert
endfunction


function s:init_buffer(winfixheight) abort
  setlocal bufhidden=wipe
  setlocal nobuflisted
  setlocal buftype=prompt
  setlocal filetype=vim
  if a:winfixheight
    setlocal winfixheight
  endif

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

  if win_gotoid(save_winid)
    call append(line('$') - 1, split(output, "\n"))
    set nomodified
  endif
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
