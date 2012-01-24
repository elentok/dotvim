" Elentok Executer Method

let g:Executer_CommandByExtension = {
      \  "rb": "ruby",
      \  "py": "python",
      \  "js": "node",
      \  "coffee": "coffee"
      \}

func! Executer()
  let filename = expand("%:t")
  let extension = tolower(expand("%:e"))
  let exec_cmd = "%"
  if filename =~ "_spec.rb"
    let exec_cmd = "rspec -c %"
  elseif has_key(g:Executer_CommandByExtension, extension)
    let exec_cmd = "" . g:Executer_CommandByExtension[extension] . " %"
  endif

  exec "silent !clear"
  exec "silent !echo '================================='"
  silent exec "!echo '$ " . expand(exec_cmd) . "'"
  exec "silent !echo '================================='"
  exec "!" . exec_cmd
endfunc

map ,r :w<cr>:call Executer()<cr>

map ,s :w<cr>:silent !clear<cr>:!rspec -c .<cr>
