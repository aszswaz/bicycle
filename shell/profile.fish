# go proxy
set -x GOPROXY https://goproxy.io/
# go
set -x GOPATH "$HOME/.cache/go"
# gdb debug repository.
set -x DEBUGINFOD_URLS https://debuginfod.archlinux.org
# default editor
set -x EDITOR /usr/bin/nvim
# wine
set -x WINEARCH win32
set -x WINEPREFIX /opt/wine
