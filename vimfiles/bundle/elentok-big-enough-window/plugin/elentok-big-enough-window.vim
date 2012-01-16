let g:minWindowWidth = 100
let g:minWindowHeight = 20

func! MakeWindowWideEnough()
  let width = winwidth(0)
  if width < g:minWindowWidth && g:minWindowWidth < &columns
    exec "normal " . g:minWindowWidth . "\<c-w>|"
  endif
endfunc

func! MakeWindowTallEnough()
  let height = winheight(0)
  if height < g:minWindowHeight && g:minWindowHeight < &lines
    exec "normal " . g:minWindowHeight . "\<c-w>_"
  endif
endfunc

func! MakeWindowBigEnough()
  call MakeWindowWideEnough()
  call MakeWindowTallEnough()
endfunc

augroup MakeWindowWideEnoughGroup
  autocmd!
  autocmd WinEnter * call MakeWindowBigEnough()
  autocmd VimResized * call MakeWindowBigEnough()
augroup END
