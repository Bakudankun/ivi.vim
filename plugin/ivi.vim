let s:save_cpo = &cpo
set cpo&vim


let s:default_config = {
      \   'bufname': 'ivi',
      \   'winheight': 0,
      \ }

if !has_key(g:, 'ivi_config')
  let g:ivi_config = {}
endif

call extend(g:ivi_config, s:default_config, 'keep')


command -count Ivi call ivi#open(<count>, <q-mods>)


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sts=2 sw=2
