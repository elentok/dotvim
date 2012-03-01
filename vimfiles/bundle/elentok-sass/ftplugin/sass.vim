compiler sass

func! SassMake()
  if expand("%:t") =~ '.css.sass'
  else
    silent make
    cw
    redraw!
  end
endfunc

augroup SassAutoCmdGroup
  autocmd!
  autocmd BufWritePost *.sass call SassMake()
augroup END
