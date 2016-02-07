#- Path Setting --------------------------------------------

typeset -U path
path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
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

