doas apt update
doas apt install git build-essential meson ninja-build pkgconf scdoc ncurses-bin \
  wayland-protocols libwayland-dev libwayland-bin libxkbcommon-dev \
  libpixman-1-dev libfreetype-dev libfontconfig-dev libharfbuzz-dev \
  libutf8proc-dev libfcft-dev libtllist-dev libffi-dev systemd-dev
doas apt install foot-terminfo

git clone https://codeberg.org/dnkl/foot.git
cd foot
git checkout 1.28.0        # or another release tag from `git tag`

meson configure bld/release -Dwerror=false
ninja -C bld/release
ninja -C bld/release install

foot --version
foot
