#- Path Setting --------------------------------------------

typeset -U path
path=(
    /bin(N-/)
    $HOME/bin(N-/)
    /opt/chef/bin(N-/)
    /usr/local/mono/bin(N-/)
    /usr/local/scala/bin(N-/)
    /usr/local/cuda/bin(N-/)
    /usr/local/llvm/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /usr/public/bin(N-/)
)

#- Sudo Path Setting ---------------------------------------

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path

sudo_path=(
    {,/usr/local,/usr}/sbin(N-/)
)

if [ $(id -u) -eq 0 ]; then
    path=($sudo_path $path)
else
    # alias sudo="sudo env PATH=\"$SUDO_PATH:$PATH\""
    :
fi

#- Function Path Setting -----------------------------------

fpath=(
    $HOME/.zsh/function(N-/)
    $fpath
)

#- Pager Setting -------------------------------------------

if type lv > /dev/null 2>&1; then
    export PAGER="lv"
else
    export PAGER="less"
fi

#- Editor Setting ------------------------------------------

export EDITOR=vim
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

#- Local Setting -------------------------------------------

if [ -e $HOME/.zshenv.local ]; then
    source $HOME/.zshenv.local
fi

