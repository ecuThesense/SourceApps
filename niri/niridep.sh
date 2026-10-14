doas apt-get install -y gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev
doas apt install rustup xwayland xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty
rustup default stable
rustc --version
cargo --version
cargo build --release


doas install -Dm755 target/release/niri \
    /usr/local/bin/niri

doas install -Dm755 resources/niri-session \
    /usr/local/bin/niri-session

doas install -Dm644 resources/niri.desktop \
    /usr/local/share/wayland-sessions/niri.desktop

doas install -Dm644 resources/niri-portals.conf \
    /usr/local/share/xdg-desktop-portal/niri-portals.conf

doas install -Dm644 resources/niri.service \
    /etc/systemd/user/niri.service

doas install -Dm644 resources/niri-shutdown.target \
    /etc/systemd/user/niri-shutdown.target

systemctl --user daemon-reload

niri-session
