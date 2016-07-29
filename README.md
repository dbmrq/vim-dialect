# dialect.vim

A simple plugin that persists the words added with `zG` and `zW` to a `spellfile` specific to the current directory.


## Usage

- Keep using `zg` and `zw` the way you always did.

- The words you add with `zG` and `zW` will be added to
`./.dialect.{encoding}.add`.

- You can change the default file with `let g:dialectfile
= "yourfile.utf-8.add"`.

That's it!

