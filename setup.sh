# Exit immediately if a command exits with a non-zero status
set -e

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Needed for all installers
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip

alias sudo="sudo"
alias install="sudo apt install -y"

echo "Installing prerequisites"
for installer in ./scripts/prereqs/*.sh; do 
  echo "Running: $installer"
  source $installer 
done

echo "Installing dev tools"
for installer in ./scripts/install/dev/*.sh; do 
  echo "Running: $installer"
  source $installer 
done

echo "Installing apps"
for installer in ./scripts/install/apps/*.sh; do 
  echo "Running: $installer"
  source $installer 
done

echo "Configuring GNOME"
for installer in ./scripts/gnome/*.sh; do 
  echo "Running: $installer"
  source $installer 
done

echo "Creating ~/projects folder"
mkdir ~/projects

echo "Setting up dotfiles config"
cd ~/projects
git clone https://github.com/javif89/dotfiles.git
cd dotfiles
./dotfiles put

echo "Setting up neovim config"
cd ~/.config
git clone https://github.com/javif89/nvim.git

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
