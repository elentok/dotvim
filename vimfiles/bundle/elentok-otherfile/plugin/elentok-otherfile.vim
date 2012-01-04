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
