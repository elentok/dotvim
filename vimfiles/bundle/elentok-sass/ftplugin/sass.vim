compiler sass

func! SassMake()
  silent make
  cw
  redraw!
endfunc

augroup SassAutoCmdGroup
  autocmd!
  autocmd BufWritePost *.sass call SassMake()
augroup END
