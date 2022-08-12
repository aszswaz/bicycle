pkgname=aszswaz-tools
pkgver=v1.0.0
pkgrel=1
pkgdesc="Some gadgets written by individuals."
arch=(x86_64)
# 软件包构建依赖
makedepends=(gcc make cmake python python-pip)
# 软件包依赖
depends=(
    neovim neovim-qt
    nodejs python python-pip
    jdk-openjdk openjdk-doc openjdk-src jdk11-openjdk openjdk11-doc openjdk11-src jdk8-openjdk openjdk8-doc openjdk8-src
    ccls gcc make cmake ctags git
    jq astyle autopep8 stylua texlive-latexindent-meta libxml2 shfmt prettier xclip
    ttf-jetbrains-mono
    openbsd-netcat
)
package() {
    cd ../
    PROJECT_DIR="$PWD"
    BIN_DIR="$pkgdir/usr/bin"
    mkdir -p "$BIN_DIR"

    cd cpp
    cmake -S . -B build --install-prefix "$pkgdir/usr"
    cd build
    make install
    cd "$PROJECT_DIR"

    cp -R shell/bin/* "$BIN_DIR"

    cp python/url-format.py "$BIN_DIR/url-format"
}
