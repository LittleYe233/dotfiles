#!/bin/bash

# Check if it is normal user
if [ `whoami` = "root" ]; then
    echo "You can't execute this script as root."
    exit 1
fi

# Command wrapper
cmdwrap() {
    # It can't print '"' and '\''. But it doesn't matter.
    printf "\n\e[32mReady for executing command: \e[1;32m%s\e[0m\n" "$*"
    read -p "Press Enter to continue ..." _t
    "$@"
}

welcome() {
    printf "\e[32mHappy that you use my dotfiles. Please ensure that you have stable access to Internet ...\e[0m\n"
}

# Main function
welcome

# Rename home folder
mv src/home/littleye233 "src/home/`whoami`"

cmdwrap sudo pacman -Syu
cmdwrap bash -c "cat pacman.txt | sed 's/#.*$//g' | xargs sudo pacman -S --needed"
cmdwrap bash -c "cd /tmp && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si"
cmdwrap bash -c "cat yay.txt | sed 's/#.*$//g' | xargs yay -S --needed"

# Better comment this and manually install it
# BUT you should ensure this hyprland dotfiles are installed before continuing
cmdwrap bash -c "bash <(curl -s 'https://end-4.github.io/dots-hyprland-wiki/setup.sh')"

# Fix issue #1030 of dots-hyprland
cmdwrap sed -i "s/@import 'material'/@import '.\/fallback\/material'/g" ~/.config/ags/scss/main.scss

cmdwrap sudo bash -c "mkdir -p /opt && cd /opt && git clone https://github.com/chiro2001/hitsz-web-login.git"
cmdwrap bash -c "curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
cmdwrap sudo bash -c "mkdir -p /var/opt && cd /var/opt && wget https://github.com/MetaCubeX/yacd/archive/gh-pages.zip && unzip gh-pages.zip && rm gh-pages.zip"
cmdwrap sed -i '1i\submap = end4global\' $HOME/.config/hypr/hyprland/keybinds.conf
cmdwrap sudo bash -c "git clone https://github.com/LittleYe233/sddm-yuri-maid-theme.git /usr/share/sddm/themes/sddm-yuri-maid-theme && sed 's/^Current=.*$/Current=sddm-yuri-maid-theme/g' /usr/lib/sddm/sddm.conf.d/default.conf"
cmdwrap bash -c "cd packages/rime-cloverpinyin-git && makepkg -si"
cmdwrap sudo rsync -av src/ /

# This command sets the wallpaper. Maybe it is broken when Hyprland isn't set up well
cmdwrap "~/.config/ags/scripts/color_generation/switchwall.sh" "~/Pictures/yande.re 1161439 peach_candy yukata yukie.png"

cmdwrap chsh -s /bin/zsh
cmdwrap bash -c "bash <(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cmdwrap git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

