
# Some base config lies here

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
plugins=(git)

## what the hek is this? I really don't know lulz

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# some conda config jazz I didn't knew where else to throw in
# also didn't want to give like it's own file so yea..

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jupyter/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jupyter/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jupyter/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jupyter/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# some shell envs vars
export DOCKER_BUILDKIT=1

