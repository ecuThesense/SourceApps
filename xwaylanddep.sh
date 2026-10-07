doas apt install libxcb-cursor-dev
git clone https://github.com/Supreeeme/xwayland-satellite.git
cd xwayland-satellite
cargo build --release

doas install -Dm755 target/release/xwayland-satellite /usr/local/bin/xwayland-satellite
