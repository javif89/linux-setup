# Prereqs
sudo apt install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

# Install yazi
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

cargo install --locked yazi-fm yazi-cli
