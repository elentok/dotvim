" Elentok Executer Method

let g:Executer_CommandByExtension = {
      \  "rb": "ruby",
      \  "py": "python",
      \  "js": "node",
      \  "coffee": "coffee"
      \}

func! Executer()
  let extension = tolower(expand("%:e"))
  exec "silent !clear"
  exec "silent !echo '================================='"
  if has_key(g:Executer_CommandByExtension, extension)
    let command = g:Executer_CommandByExtension[extension]
    exec "silent !echo 'Executing " . command . " " . expand("%") . "'"
    exec "silent !echo '================================='"
    exec "!" . command . " %"
  else
    exec "!%"
  endif
endfunc

map ,r :w<cr>:call Executer()<cr>
