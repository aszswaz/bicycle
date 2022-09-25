pkgname=aszswaz-tools
pkgver=v1.0.0
pkgrel=3
pkgdesc="Some gadgets written by individuals."
arch=(x86_64)
# 软件包构建依赖
makedepends=(gcc make cmake python python-pip)
# 软件包依赖
depends=(
    gcc nasm
    nodejs python
    jdk-openjdk openjdk-doc openjdk-src jdk11-openjdk openjdk11-doc openjdk11-src jdk8-openjdk openjdk8-doc openjdk8-src
    ccls make cmake ctags python-pip git gdb valgrind
    qt5-base nlohmann-json python-pynvim
    neovim neovim-qt
    jq astyle autopep8 stylua texlive-latexindent-meta libxml2 shfmt prettier
    openbsd-netcat v2ray curl libqalculate xclip
    ttf-jetbrains-mono
    fish
)

build() {
    cd ../
    PROJECT_DIR="$PWD"

    cd cpp
    cmake -DCMAKE_BUILD_TYPE=RELEASE -S . -B build --install-prefix "$pkgdir/usr"
    cd build
    make
    cd "$PROJECT_DIR"
}

package() {
    cd ../
    PROJECT_DIR="$PWD"
    BIN_DIR="$pkgdir/usr/bin"
    mkdir -p "$BIN_DIR"

    cd cpp/build && make install && cd "$PROJECT_DIR"
    cp -R shell/bin/* "$BIN_DIR"
    cp python/url-format.py "$BIN_DIR/url-format"

    for file in $pkgdir/usr/bin/*; do
        chmod a+rx "$file"
    done
}
