# Maintainer: Raj Jagadeesh A P <rajjagadeesh2006@gmail.com>
pkgname=hypr-game-mode
pkgver=1.0.0
pkgrel=4
pkgdesc="TUI Gaming Dashboard for Hyprland: Scrcpy, Game Launcher, & Hardware Optimizer"
arch=('any')
url="https://github.com/Raj-Jagadeesh-A-P/hypr-game-mode"
license=('GPL3')
depends=('bash' 'hyprland' 'fzf' 'scrcpy' 'android-tools' 'libnotify' 'mangohud' 'gamemode')
makedepends=()
source=("$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$pkgname-$pkgver"
    install -Dm755 hypr-game-mode "$pkgdir/usr/bin/hypr-game-mode"
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
