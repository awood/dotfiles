# CLAUDE.md - Local User Preferences

## Output Preferences
* Do not produce trailing recap or summary blocks (e.g. "※ recap:") at the end
  of responses.  The work is visible in the diffs and tool output.

## Language Preferences
* Do not use "+" or "&" to mean "and".  Instead write the word.
* Keep emoji usage to a minimum.  Usage for status printed to the terminal is
  acceptable.  Usage in section headings of documents is not.
* Do not editorialize or provide affirmation with remarks like "Good question,"
  "Great point," or similar.

## Technology Preferences
* For ad hoc scripting prefer Python or shell scripting.  Use of Javascript is
  highly discouraged and should be considered a last resort.
* Instead of using `find` to search by suffix and then an `-exec`, to `grep`
  within the files, use the `rg` tool.  Specifically, use `-uu` flags to broaden
  the search and `-t` to filter by file type.
* Use `jq` for JSON parsing whenever practical.  Avoid ad hoc python scripts
  provided via the `-c` argument.

## Naming Practices
* Use the `-` rather than `_` as the word separator when naming files unless
  otherwise instructed.

## Coding Practices
* Comment liberally, but comments must provide semantic meaning beyond a plain
  reading of the code.  Comments should be comprehensive, include references
  where necessary, and be primarily focused on the "why" behind a piece of code.
  Comments on the "how" of a piece of code should be reserved for unusual
  idioms, structures, or usages.
* Java classes should provide JavaDoc judiciously.   Simple or straightforward
  methods need not provide JavaDoc, but classes and more complex methods should
  always include proper Javadoc.

## Operational Practices
* Place flags after subcommands so that permissions can easily be granted to
  subcommands through globbing.  For example, prefer `./mvnw test -pl
  swatch-tally` over `./mvwn -pl swatch-tally test` so that `./mvnw test *` will
  match.
* If the working directory isn't part of the git repository we're working on,
  prefer `git -C <path> <subcommand>` over `cd <path> && git ...`.  The `-C`
  form keeps each invocation as a single command, making permission glob
  patterns simpler and avoiding side effects from directory changes.  Do not use
  `-C` unless there is this working directory/repository directory mismatch
  (running a git command in a different worktree, for example).
* If the user requests for output in Markdown, they mean unrendered Markdown
  suitable for pasting elsewhere.  Do not print rendered items unless the
  request is for "rendered Markdown."

## Shell Scripting
* Write scripts using Bash "strict mode" by placing the following at the top of
  scripts
    ```
    #! /usr/bin/env bash
    # https://github.com/olivergondza/bash-strict-mode
    set -eEuo pipefail
    trap 's=$?; echo >&2 "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
    ```

