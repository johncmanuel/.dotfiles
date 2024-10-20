#!/bin/sh
# Based off of: https://github.com/guptarohit/dotfiles/blob/main/install.sh

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Sometimes .zshrc files already exist and need to install
# ohmyzsh
remove_existing_zshrc() {
  if [ -f "$HOME/.zshrc" ]; then
    echo "Removing existing .zshrc file..."
    rm "$HOME/.zshrc"
  fi
}

clone_or_pull() {
  repo_url=$1
  directory=$2

  if [ ! -d "$directory" ]; then
    git clone "$repo_url" "$directory" || exit 1
  else
    cd "$directory" && git pull "$repo_url" || exit 1
  fi
}

install_package() {
  if command_exists apt-get; then
    sudo apt-get install -y "$1"
  elif command_exists yum; then
    sudo yum install -y "$1"
  elif command_exists pacman; then
    sudo pacman -S --noconfirm "$1"
  elif command_exists dnf; then
    sudo dnf install -y "$1"
  else
    echo "Unsupported package manager. Please install $1 manually."
    exit 1
  fi
}

setup_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
    return
  fi
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
}

setup_devbox() {
  if command_exists devbox; then
    echo "Devbox is already installed."
    return
  fi
  echo "Installing Devbox..."
  sh -c "$(curl -fsSL https://get.jetify.com/devbox)"
}

setup_ani_cli() {
  if command_exists ani-cli; then
    echo "Ani-cli is already installed."
    return
  fi
  echo "Installing Ani-cli..."
  clone_or_pull "https://github.com/pystardust/ani-cli.git" "$HOME/ani-cli"
  sudo cp "$HOME/ani-cli/ani-cli" /usr/local/bin
  rm -rf "$HOME/ani-cli"
}

install_pkg() {
  if ! command_exists "$1"; then
    echo "Installing $1..."
    install_package "$1"
  else
    echo "$1 is already installed."
  fi
}

install_zsh_plugins() {
  ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
  type=$1
  name=$2
  repo=$3

  if [ "$type" = "theme" ]; then
    plugin_path=$ZSH_CUSTOM/themes
  elif [ "$type" = "plugin" ]; then
    plugin_path=$ZSH_CUSTOM/plugins
  else
    echo "Invalid type: $type"
    return 1
  fi

  plugin_path=$plugin_path/$name

  echo "Installing zsh $type, $name..."

  clone_or_pull "$repo" "$plugin_path"
}

install_brew() {
  if command_exists brew; then
    echo "Homebrew is already installed."
    return
  fi

  /bin/bash "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "eval '$(/opt/homebrew/bin/brew shellenv)'" >>"$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

setup_brew_dependencies() {
  if command_exists brew; then
    echo "Installing brew dependencies..."
    brew update
    brew tap homebrew/bundle
    brew tap homebrew/cask-fonts
    brew bundle --file ./Brewfile
  fi
}

main() {
  echo "Starting installation process..."

  mkdir -p "$HOME/.config"
  remove_existing_zshrc

  # check if OS is a mac. if mac, install brew and setup brew dependencies
  if [ "$(uname)" = "Darwin" ]; then
    echo "Mac OS detected, installing Homebrew..."
    install_brew
    setup_brew_dependencies
  else
    # not sure if this will work, don't wanna test it rn haha
    install_pkg "stow"
    install_pkg "zsh"
    install_pkg "git"
    install_pkg "neovim"
  fi

  setup_devbox

  setup_oh_my_zsh
  install_zsh_plugins plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
  install_zsh_plugins plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
  install_zsh_plugins plugin zsh-completions https://github.com/zsh-users/zsh-completions

  echo "Setup config files with stow"
  cd "$HOME/.dotfiles" || exit 1

  stow stow
  stow devbox
  stow zsh
  stow git
  stow fastfetch
  stow nvim
  stow ripgrep
  stow starship

  echo "Installation process completed!"
}

main
