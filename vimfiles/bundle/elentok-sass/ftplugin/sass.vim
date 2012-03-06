compiler sass

func! SassMake()
  if expand("%:t") =~ '.css.sass' || expand("%:t") =~ 'application.sass'
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
