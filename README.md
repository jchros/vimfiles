# vimfiles
A partial copy of my current .vim directory.

**Note:**
Feel free to copy any part of this repository that interests you; the
very permissive license of this repository (0BSD) was chosen to
encourage this.
However, you should probably not clone this repository in your machine;
it's very rewarding to build your Vim configuration yourself! My vimrc
does stuff you may not want to do (e.g. automatically install minpac).

## Micro-plugins

Here are some plugins I wrote that aren't big enough to deserve their
own GitHub repositories:

- [`cmus.vim`](plugin/cmus.vim): Ex commands and mappings to control
  cmus.
- [`ctrl_e.vim`](plugin/ctrl_e.vim): Adds an insert mode mapping (bound
  to `CTRL_E`) which jumps to the end of the current line and closes
  brackets and quoted strings.
- [`indent_settings.vim`](plugin/indent_settings.vim): Ex commands to
  quickly change the values of `'expandtab'`, `'tabstop'`,
  `'softtabstop'`, and `'shiftwidth'`.
- [`repeat.vim`](plugin/repeat.vim): A bunch of mappings I added to use
  the fact that there is no text object named `r`: `dr` makes a
  **d**elete then a **r**epeat, and `yr` makes a **y**ank then a
  **r**epeat (both commands leave registers unchanged).
- [`timecalc.vim`](plugin/timecalc.vim): two functions and an Ex
  command for calculating the sum of a list of durations; see [the
  documentation](doc/timecalc.txt).

These are also licensed under the [0BSD license](LICENSE).

## Cool mappings for AZERTY keyboards

As a user of an AZERTY keyboard, I've added a few mappings taking
advantage of the keys unused by Vim.
If that's interesting to you, feel free to copy the lines of code below
in your vimrc.

```vim
" Quickly insert a blank line
" Convenient mappings for Apple's AZERTY keyboard
nnoremap <expr> § 'o<Esc>' . v:count1 . 'kgM'
nnoremap        ¶ O<Esc>jgM

" Toggle casing of a single character
noremap ç ~
" Toggle casing of a word
vnoremap Ç viw~

" Typing the pipe character is inconvenient in AZERTY keyboards
cnoremap § \|
inoremap § \|
tnoremap § \|
```
