# Maintainer: Raj Jagadeesh A P <rajjagadeesh2006@gmail.com>
pkgname=hypr-game-mode
pkgver=1.0.0
pkgrel=5
pkgdesc="TUI Gaming Dashboard for Hyprland: Scrcpy, Game Launcher, & Hardware Optimizer"
arch=('any')
url="https://github.com/Raj-Jagadeesh-A-P/hypr-game-mode"
license=('GPL-3.0-or-later')
depends=('bash' 'fzf' 'scrcpy' 'android-tools' 'libnotify' 'mangohud' 'gamemode')
makedepends=()
source=("$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$pkgname-$pkgver"
    install -Dm755 hypr-game-mode "$pkgdir/usr/bin/hypr-game-mode"
    install -dm755 "$pkgdir/usr/lib/$pkgname"
    install -Dm644 lib/constants.sh "$pkgdir/usr/lib/$pkgname/constants.sh"
    install -Dm644 lib/logging.sh "$pkgdir/usr/lib/$pkgname/logging.sh"
    install -Dm644 lib/utils.sh "$pkgdir/usr/lib/$pkgname/utils.sh"
    install -Dm644 lib/config.sh "$pkgdir/usr/lib/$pkgname/config.sh"
    install -Dm644 lib/game_mode.sh "$pkgdir/usr/lib/$pkgname/game_mode.sh"
    install -Dm644 lib/launcher.sh "$pkgdir/usr/lib/$pkgname/launcher.sh"
    install -Dm644 lib/android.sh "$pkgdir/usr/lib/$pkgname/android.sh"
    install -Dm644 lib/menus.sh "$pkgdir/usr/lib/$pkgname/menus.sh"
    install -Dm644 lib/main.sh "$pkgdir/usr/lib/$pkgname/main.sh"
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
