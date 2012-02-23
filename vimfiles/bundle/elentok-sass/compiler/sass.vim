
if exists('current_compiler')
  finish
endif

let current_compiler = 'sass'

let sass_args = ' --update --force --no-cache '

let &makeprg='sass ' . sass_args . fnameescape(expand("%"))

CompilerSet errorformat=WARNING\ on\ line\ %l\ of\ %f:
