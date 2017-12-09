# dialect.vim

A simple plugin that persists the words added with `zG` and `zW` to a
`spellfile` specific to the current file or directory.


## Usage

- Keep using `zg` and `zw` the way you always did.

- The words you add with `zG` and `zW` will be added to
`./.dialect.{encoding}.add`.

- By default, `dialect.vim` uses a `spellfile` for each directory. If you want
  a different `spellfile` for each specific file, add this to your `.vimrc`:
  `let g:dialectmode = 'file'`. You can also add a file called `.dialectmain`
  to a directory and all files in its subdirectories will use the `spellfile`
  there.

That's it!


## See also

You may also be interested in my other plugins:

- [Ditto: highlight overused words](https://github.com/dbmrq/vim-ditto) :speak_no_evil:
- [Redacted: the best way to ████ the ████](https://github.com/dbmrq/vim-redacted) :no_mouth:
- [Chalk: better fold markers](https://github.com/dbmrq/vim-chalk) :pencil2:
- [Howdy: a tiny MRU start screen for Vim](https://github.com/dbmrq/vim-howdy) :wave:


