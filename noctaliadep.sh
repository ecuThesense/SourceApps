doas apt install just meson libwayland-dev \
  wayland-protocols libfreetype-dev libfontconfig-dev \
  libcairo2-dev libpango1.0-dev librsvg2-dev libxkbcommon-dev \
  libepoxy-dev libgles-dev libwebp-dev libcurl4-gnutls-dev \
  libmd4c-dev nlohmann-json3-dev libsdbus-c++-dev libsecret-1-dev \
  libsodium-dev libstb-dev libtomlplusplus-dev \
  libpipewire-0.3-dev libpam0g-dev libpolkit-agent-1-dev \
  libpolkit-gobject-1-dev libqalculate-dev libwireplumber-0.5-dev \
  libxml2-dev libjemalloc-dev git libical-dev libjxl-dev libsndfile1-dev wayland-protocols

git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git
cd wayland-protocols
git checkout 1.48

meson setup build \
  --prefix=/usr/local

meson compile -C build
doas meson install -C build

git clone https://github.com/noctalia-dev/noctalia --branch main
cd noctalia

just configure release
just build release
doas just install release

# just uninstall release
