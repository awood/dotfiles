# Intellij Keyboard Shortcut Quick Reference

## General
`SHIFT-Esc` or \tq      Hide active tool window
`\th`                   Hide all tool windows
`CTRL-SHIFT-A`          Find action
`CTRL-SHIFT-S`          Open settings
`ALT-1`                 Project tool window
`ALT-2`                 Bookmarks tool window
`ALT-3`                 Find tool window
`ALT-4`                 Run tool window
`ALT-5`                 Debug tool window
`ALT-6`                 Problems tool window
`ALT-7`                 Structure tool window
`ALT-8`                 Services tool window
`ALT-9` or `\tg`        Git tool window
`ALT-0`                 Commit tool window
`ALT--` or `\tt`        Terminal tool window
`ALT-M`                 String manipulation quick-list (plugin)
`[on`/`]on`             Line numbers on/off
`[or`/`]or`             Relative line numbers on/off
`\dd`                   Show error description

## Debugging
`F7`            Step into
`F8`            Step over
`F9`            Resume program
`CTRL-F8`       Toggle breakpoint
`SHIFT-F8`      Step out
`ALT-F8`        Evaluate expression
`CTRL-SHIFT-F8` View breakpoints
`ALT-F9`        Run to cursor
`CTRL-SHIFT-ALT-<click>` or `CTRL-ALT-8`     Quick evaluate

## Search and Replace
Double `SHIFT`          Search everywhere
`CTRL-F`                Find
`F3`/`SHIFT-F3`         Find next/previous
`CTRL-ALT-R`            Replace
`CTRL-SHIFT-F`          Find in files
`CTRL-SHIFT-N`          Replace in files
`CTRL-F3/CTRL-SHIFT-F3` Next occurrence of word at caret
`ALT-J`                 Add selection for next occurrence
`CTRL-ALT-SHIFT-J`      Add selection for all occurrences
`ALT-SHIFT-J`           Unselect occurrences
`CTRL-ALT-E`            Search in selection

## Editing
`ALT-Up`/`ALT-Down`             Move line up/down
`SHIFT-ALT-Up`/`SHIFT-ALT-Down` Method up/down
`CTRL-SHIFT-DEL`                Unwrap
`CTRL-ALT-L` or `\rf`           Reformat code
`CTRL-ALT-SHIFT-L`              Reformat file
`CTRL-L`                        Extend selection
`CTRL-SHIFT-L`                  Shrink selection
`ALT-I`                         Implement methods
`ALT-O`                         Override methods
`CTRL-SHIFT-O`                  Optimize imports
`CTRL-L`                        Extend selection
`CTRL-SHIFT-L`                  Shrink selection
`CTRL-D`                        Delete current line
`CTRL-Y`                        Duplicate current line
`]<space`/`]<space>`            Insert line above/below
`\p`                            Paste over selection without killing register 1

## Refactoring
`F5`                    Copy
`F6`                    Move
`SHIFT-F6` or `\rn`     Rename
`CTRL-F6` or `\rs`      Change signature
`CTRL-ALT-SHIFT-T`      Refactor this...
`ALT-Delete`            Safe delete
`CTRL-ALT-N`            Inline
`CTRL-ALT-M` or `\re`   Extract method
`CTRL-ALT-C`            Introduce constant
`CTRL-ALT-F`            Introduce field
`CTRL-ALT-P`            Introduce parameter
`CTRL-ALT-V`            Introduce variable
`\rr`                   Refactoring Quicklist

## Navigation
`]b`/`[b`               Previous/next tab
`]q`/`[q`               Previous/next error
`]c`/`[c`               Previous/next VCS change
`\q`                    Close tab
`\Q`                    Reopen recently closed
`\nl`                   Recent locations
`\tn`                   NERDTree
`CTRL-E`                Recent files
`CTRL-M`                File structure popup
`CTRL-SHIFT-T`          Go to class
`CTRL-SHIFT-R`          Go to file
`CTRL-SHIFT-S`          Go to symbol
`SHIFT-ALT-U` or `\nt`  Go to test
`CTRL-PgUp`             Previous tab
`CTRL-PgDown`           Next tab
`CTRL-H`                Type hierarchy
`CTRL-SHIFT-H`          Method hierarchy
`CTRL-ALT-H` or `\nh`   Call hierarchy
`CTRL-B`                Go to declaration
`CTRL-ALT-B` or '\ni'   Go to implementation
`ALT-U` or '\ns'        Go to super method/class
`CTRL-SHIFT-B`          Go to type declaration
`F2`/`SHIFT-F2`         Next/previous error

## Compile and Run
`\ed`           Debug
`\ecd`          Debug class
`\esd`          Choose debug configuration
`\er`           Run
`\ecr`          Run class
`\esr`          Choose run configuration

## Usage Search

## Git
`ALT-D`                 Show diff
`SHIFT-ALT-D`           Compare two files

## Other
`SHIFT-CTRL-ALT-O`      Reload `.ideavimrc
`SHIFT-ALT-H`           Toggle inline hints
`CTRL-ALT-A`            Toggle IdeaVim
`CTRL-ALT-1`            Custom "Quick Development" quicklist
'SHIFT-ALT-Y`           SonarLint analyze files
`ALT-D`                 Show diff

## Live Templates
`psflog`                SLF4J logger

## Postfix Completion
`arg`                   `functionCall(expr)`
`assert`                `assert expr`
`cast`                  `((SomeType) expr)
`castvar`               `T name = (T) expr`
`else`                  `if (!expr)`
`field`                 `myField = expr` (creates a field for the expr also)
`for`                   `for (T item : expr)`
`fori`                  `for (int i = 0; i < expr.length; i++)`
`format`                `String.format(expr)`
`forr`                  `for (int i = expr.length - 1; i >=0; i--)`
`if`                    `if (expr)`
`instanceof`            `expr instanceof Type ? ((Type) expr : null`
`lambda`                `() -> expr`
`new`                   `new T()`
`not`                   `!expr`
`notnull`               `if (expr != null)`
`null`                  `if (expr == null)`
`opt`                   `Optional.ofNullable(expr)`
`par`                   `(expr)`
`reqnonnull`            `Objects.requireNonNull(expr)`
`return`                `return expr`
`serr`                  `System.err.println(expr)`
`souf`                  `System.out.printlf("", expr)`
`sout`                  `System.out.println(expr)`
`soutv`                 As `sout` but with a description (`"b = " + expr`)
`stream`                `Arrays.stream(expr)`
`switch`                `switch(expr)`
`synchronized`          `synchronized(expr)`
`throw`                 `throw expr`
`try`                   `try { expr } catch (Exception e)`
`twr`                   `try (Type f = new Type()) catch (Exception e)`
`var`                   `T name = expr`
`while`                 `while (expr) {}`
