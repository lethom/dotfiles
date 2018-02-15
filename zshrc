export ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="sorin"

setopt hist_ignore_all_dups
setopt hist_find_no_dups

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git git-extras git-remote-branch git-prompt colored-man-pages per-directory-history stack npm python history-substring-search)

source $ZSH/oh-my-zsh.sh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'r' history-substring-search-up
bindkey -M vicmd 's' history-substring-search-down

function pijul_current_branch() {
    echo "$(~/.cargo/bin/pijul branches 2> /dev/null | grep \* | sed 's/\* *//')" || true
}

function git_status() {
    git status 2> /dev/null 1> /dev/null
    if [[ $? -ne 0 ]]; then
        return 0
    fi

    if [[ -z "$(git status 2> /dev/null | grep "nothing to commit")" ]]; then
        return 1 # if there is something to commit, return 1
    else
        return 0
    fi
}

function pijul_status() {
    .cargo/bin/pijul diff 2> /dev/null 1> /dev/null
    if [[ $? -ne 0 ]]; then
        return 0
    fi

    if [[ -n "$(~/.cargo/bin/pijul diff 2> /dev/null)" ]]; then
        return 1 # if there is a diff, then return 1
    else
        return 0
    fi
}

function get_status() {
    git_status
    local git=$?

    pijul_status
    local pijul=$?

    # if either git or pijul is not null, we shall do something
    return $((${git} + ${pijul}))
}

# because `current_branch` is a git specific tool, here is a wrapper
# to also deal with pijul
function get_current_branch() {
    if [[ -n "$(pijul_current_branch)" ]]; then
        echo "$(pijul_current_branch)"
    elif [[ -n "$(current_branch)" ]]; then
        echo "$(current_branch)"
    fi
}

function pretty_branch_color() {
  if [ -z "$(get_current_branch)" ]; then
    echo "%{%10F%}$(pwd)%{%f%}"
    return
  fi

  get_status
  if [ $? -eq 0 ]; then
    echo "%{%2F%}$(get_current_branch)%{%f%}%{%8F%} `basename $(pwd)`"
  else
    echo "%{%1F%}$(get_current_branch)%{%f%}%{%8F%} `basename $(pwd)`"
  fi
}

PROMPT="%{%12F%}λ %{%f%}"
RPROMPT='$(pretty_branch_color)'

export EDITOR=/usr/local/bin/editor

# OPAM configuration
. /home/lethom/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH=~/.local/bin:~/Repos/pijul/target/release/:${PATH}
alias pijul-rel=~/.cargo/bin/pijul
alias tectonic=~/.cargo/bin/tectonic

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
