
# RUN THESE SCRIPTS AS ROOT
# sudo -i
# Include tap-to-click method on touchpads
sudo cat << EOF > /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
EndSection
EOF

# Install new shell, customizations, emacs and others
sudo pacman -S --noconfirm zsh wget
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
usermod -s /bin/zsh cesar

cat << EOF > /home/cesar/.zshrc
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="rkj-repos"
DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=13
plugins=(git github)

source $ZSH/oh-my-zsh.sh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nano'
fi
EOF
