# dialect.vim

A simple plugin that persists the words added with `zG` and `zW` to a
`spellfile` specific to the current file or directory.


## Usage

- Keep using `zg` and `zw` the way you always did.

- The words you add with `zG` and `zW` will be added to
`./.dialect.{encoding}.add`.

- By default, `dialect.vim` uses a `spellfile` for each directory. If you want
  a different `spellfile` for each specific file, add this to your `.vimrc`:
  `let g:dialectmode = 'file'`.

That's it!


## See also

You may also be interested in my other plugins:

- [Ditto: highlight overused words](https://github.com/dbmrq/vim-ditto) :speak_no_evil:
- [Chalk: better fold markers](https://github.com/dbmrq/vim-chalk) :pencil2:


