ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
export LANG=en_US.UTF-8


ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi


# export TERMINAL=alacritty
export TERM=xterm-256color
export PATH=$HOME/.local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=86'

ZSH_THEME=""
setopt COMPLETE_ALIASES
setopt auto_cd
setopt multios
setopt prompt_subst


#if [[ -n "$SSH_CONNECTION" ]] ;then
#    export PINENTRY_USER_DATA="USE_CURSES=1"
#fi


# Set up the prompt
# autoload -Uz promptinit
# promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/ubuntu", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/dotenv", from:oh-my-zsh
zplug "plugins/vscode", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "darvid/zsh-poetry"
open() { xdg-open &>/dev/null $1 & }
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias cpkey="pbcopy < ~/.ssh/id_rsa.pub"
alias gpg=gpg2
# alias coffee=~/coffee.sh
alias ua="sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y"
# xrandr --output DP-1-2 --auto --right-of DisplayPort-3
source $HOME/.secrets
wttr() { curl "https://wttr.in/$1" }

# zplug "plugins/git", from:oh-my-zsh

if ! zplug check; then
    zplug install
fi

zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

pyenv virtualenvwrapper

fbr() {
  git fetch
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export fpath=(/usr/share/bash-completion/completions $fpath)

_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


get_po() {
	kubectl -n $1 get po | cut -f1 -d " " | grep $2
}
source $HOME/.poetry/env

deploy-edge() {
    deployment-tool deploy --version=version/$1 backend/deployment.yml.jinja2 backend/profiles/production/$2_variables.yml --pause-deployment --no-git
}
pfg() {
	pip freeze | grep $1
}
export PATH=$(yarn global bin):$PATH
export PATH="$HOME/.cargo/bin:$PATH"

