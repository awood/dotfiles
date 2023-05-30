## Git FZF
| Keystroke | Action |
|---|---|
| CTRL-G CTRL-F | Files                        |
| CTRL-G CTRL-B | Branches                     |
| CTRL-G CTRL-T | Tags                         |
| CTRL-G CTRL-R | Remotes                      |
| CTRL-G CTRL-H | Commit hashes                |
| CTRL-G CTRL-S | Stashes                      |
| CTRL-G CTRL-E | Each ref (`git for-each-ref`)|

## Custom FZF Functions
* `cdf` -
  `cd` into the directory of the selected file
* `irg` -
  interactive `ripgrep`. Switch between `ripgrep` (`CTRL-R`) and `fzf` filtering mode (`CTRL-F`)
* `tm [SESSION NAME]` -
  create a new `tmux` session or switch to an existing session. Works within tmux as well.
* `fe [FUZZY PATTERN]` -
  open the selected file with the default editor
* `podrmi` -
  multi-select podman images using `TAB` to delete them

## FZF Shell Bindings
* `ALT-C`  - `cd` to a directory under the current directory
* `CTRL-T` - completion
* `CTRL-R` - shell history

## FZF Vim
| Binding | Command | Action |
| --- | --- | --- |
| \b  | :Buffers  | open buffers     |
| \m  | :Marks    | marks            |
| \f  | :Files    | search files     |
| \gf | :GFiles   | `git ls-files`   |
| \gs | :GFiles?  | `git status`     |
| \hs | :History/ | search history   |
| \hc | :History: | command history  |
| \rg | :Rg       | `ripgrep` search |

### Other FZF Vim commands
| Command | Action |
| --- | --- |
| :Files [PATH]        | Files (runs $FZF_DEFAULT_COMMAND if defined) |
| :GFiles [OPTS]       | Git files (git ls-files) |
| :GFiles?             | Git files (git status) |
| :Ag [PATTERN]        | ag search result (ALT-A to select all, ALT-D to deselect all) |
| :Rg [PATTERN]        | rg search result (ALT-A to select all, ALT-D to deselect all) |
| :Lines [QUERY]       | Lines in loaded buffers |
| :BLines [QUERY]      | Lines in the current buffer |
| :Tags [QUERY]        | Tags in the project (ctags -R) |
| :BTags [QUERY]       | Tags in the current buffer |
| :Windows             | Windows |
| :Locate PATTERN      | locate command output |
| :History             | v:oldfiles and open buffers |
| :Commits [LOG_OPTS]  | Git commits (requires fugitive.vim) |
| :BCommits [LOG_OPTS] | Git commits for the current buffer; visual-select lines to track changes in the range |
| :Commands            | Commands |
| :Maps                | Normal mode mappings |
| :Helptags            | Help tags 1 |
| :Filetypes           | File types |
