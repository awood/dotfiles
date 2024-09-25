export EDITOR="vim"
export VISUAL="vim"
export LESS="-M --jump-target=5 --shift 4"
export PROJECT_HOME="$HOME/devel"
export WORKON_HOME="$HOME/.virtualenvs"
export VAGRANT_DEFAULT_PROVIDER="libvirt"
# Disable color warnings in pre-commit as pre-commit colors the background
# rather than the text and that doesn't display nicely with my color scheme
export PRE_COMMIT_COLOR="never"

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true

export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

export PSQL_PAGER='pspg'

# Default is underline which I find annoying
export ZSH_HIGHLIGHT_STYLES[path]=none
export ZSH_HIGHLIGHT_STYLES[comment]='fg=bright-gray'
