let s:OtherFile_extensions = { "js": "coffee", "coffee": "js", "scss": "css", "css": "scss" }

func! OtherFile()
  let ext = tolower(expand("%:e"))
  let newext = ""
  if has_key(s:OtherFile_extensions, ext)
    let newext = s:OtherFile_extensions[ext]
    let otherfile = substitute(expand("%"), "\." . ext . "$", "." . newext, "")
    call OpenFile(otherfile)
  endif
endfunc

func! OpenFile(filename)
  if bufexists(a:filename)
    exec "buffer " . a:filename
  else
    exec "edit " . a:filename
  endif
endfunc

map `o :call OtherFile()<cr>

func! SwitchBetweenSpecAndSource()
  let filename = expand("%:t")
  let other_buffer = ""
  if filename =~ "_spec"
    let other_buffer = substitute(filename, "_spec", "", "")
  else
    let other_buffer = expand("%:t:r") . "_spec." . expand("%:e")
  endif

  if other_buffer != ""
    let buffer_name = bufname(other_buffer)
    if buffer_name != ""
      exec "buffer " . buffer_name
    else
      exec "e **/" . other_buffer
    endif
  endif
endfunc

map `p :call SwitchBetweenSpecAndSource()<cr>
