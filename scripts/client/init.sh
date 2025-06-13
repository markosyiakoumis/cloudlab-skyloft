apt-get update
apt-get install -y libnuma-dev libcap-dev libclang-dev
curl https://sh.rustup.rs -sSf | sh
. "$HOME/.cargo/env"
rustup install nightly

# Download and Build DPDK
cd /local/shenango-client-master
./dpdk.sh
