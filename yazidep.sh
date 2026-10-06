rustup update
doas apt update && doas apt upgrade
doas apt install imv kitty -y

git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo xtask build

mv target/release/yazi target/release/ya /usr/local/bin/
