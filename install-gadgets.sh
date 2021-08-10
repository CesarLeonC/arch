# Install oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Export personal config
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

# Changing default shell
sudo usermod -s /bin/zsh cesar
