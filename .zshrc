# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zinit pkg manager 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k


# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color always --icon=always $realpath'
# emax key
bindkey -e 
bindkey '\ej' backward-char     # Alt + j = ←
bindkey '\ek' up-line-or-history # Alt + k = ↑
bindkey '\el' down-line-or-history # Alt + l = ↓
bindkey '\e;' forward-char      # Alt + ; = →


# Enable shared history across sessions
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY       # Immediately append new commands to history file
setopt SHARE_HISTORY            # Share history across all sessions
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt HIST_VERIFY              # Show command with history expansion before running
export TERMINAL="alacritty"

export GDK_SCALE=1
export GDK_DPI_SCALE=1
export EDITOR="nvim" 
export VISUAL="nvim" 
export MANPAGER='nvim +Man!'
alias zconf="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias iconf="nvim ~/.config/i3/config"
alias iexit="i3-msg exit"
alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'
alias copy='xclip -selection clipboard'
alias ts="tmux-sessionizer"
alias td="tmux detach"
alias tk="tmux kill-session"
alias tl="tmux ls"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"
[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv > /dev/null; then
  eval "$(pyenv init --path)"
fi

fuck (){
	sudo $( history -1 | awk '{print $2}' )
}
# Created by `pipx` on 2025-06-06 10:58:02
export PATH="$PATH:/home/zaater/.local/bin"

sync_dotfiles() {
  rsync -av --update --exclude=".git" --exclude=".config/thorium/" ~/.{xprofile,Xresources,zshrc,config,tmux.conf} ~/git/dotfiles/
}

