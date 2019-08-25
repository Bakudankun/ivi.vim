let s:save_cpo = &cpo
set cpo&vim


let g:ivi_bufname = get(g:, 'ivi_bufname', 'ivi')


command -count Ivi call ivi#open(<count>, <q-mods>)


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sts=2 sw=2
