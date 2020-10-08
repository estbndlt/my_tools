###############################################################################
# common variables
###############################################################################
# get the right c drive prefix
if [[ $(cat /proc/version | awk '{ print $1 }') =~ CYGWIN ]]; then
    export CDRIVE='/cygdrive/c'
elif [[ $(cat /proc/version | awk '{ print $1 }') =~ MINGW ]]; then
    export CDRIVE='/c'
elif [[ $(cat /proc/version | awk '{ print $1 }') =~ Linux ]]; then
    export CDRIVE='/mnt/c'
fi

###############################################################################
# custom variables (UPDATE HERE)
###############################################################################
# save the username (required to update .gitconfig from embedded repo)
export USERNAME="edelatorre"

# save the full name (required to update .gitconfig from embedded repo)
export FULLNAME="Esteban de la Torre"

# custom path variables (required to work with refresh())
export EMBEDDED="${CDRIVE}/git/embedded"
export EMBEDDEDCONFIG="${EMBEDDED}/scm/git/config/win_git_bash"

# paths to config files (required to work with refresh())
export MYCONFIGPATH="${CDRIVE}/git/my_tools/config"
export MYBASHRCPATH="${MYCONFIGPATH}/.bashrc"
export MYGITCONFIGPATH=""
export MYINPUTRCPATH="${MYCONFIGPATH}/.inputrc"
export MYVIMRCPATH="${MYCONFIGPATH}/.vimrc"

###############################################################################
# git aliases/functions
###############################################################################
alias ga="git add"
alias gau="git add -u ."
alias gs="git status"
alias gd="git diff"
alias gdom="git diff origin/master"
alias gf="git fetch --prune"
alias gr="git rebase"
alias grom="git rebase --ignore-date origin/master"
alias gb="git branch"
alias gbd="git branch -D"
alias gbdr="git push --delete origin"
alias gba="git branch -avv"
alias gl="git log --all --decorate --oneline --graph"
alias gpp="git push"
alias gpf="git push --force-with-lease"
alias gcm="git commit -m"
alias grh="git reset --hard"
alias gcl="git clean -dxf"
alias gcr="git clean -dxf && git reset --hard"
alias gsp="git stash pop"
alias gst="git stash"
alias gcom="git checkout master"

# git rebase for squashing
gri() {
    git rebase -i "HEAD~$1"
}

# git checkout remote branch
gconb() {
    git checkout -b "$1" "origin/$1"
}

# git log compare branch with master
glom() {
    git lg ^origin/master "$(git rev-parse --abbrev-ref HEAD)"
}

##############################################################################
# svn aliases
##############################################################################
alias sst="svn status"
alias sstm="svn status . | grep \"^M\""
alias sstn="svn status . | grep \"^?\""
alias sco="svn checkout"
alias sr="svn reset"
alias srh="svn reset -R ."
alias scu="svn cleanup . --remove-unversioned"

###############################################################################
# navigation aliases
###############################################################################
# quick cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# repos
alias ghome="cd ${CDRIVE}/git"
alias shome="cd ${CDRIVE}/SVN"

# custom paths
alias dev="cd ${CDRIVE}/SVN/dev"
alias emb="cd ${CDRIVE}/git/embedded"
alias dt="cd ${CDRIVE}/Users/${USERNAME}/Desktop"
alias dl="cd ${CDRIVE}/Users/${USERNAME}/Downloads"
alias dto="cd ${CDRIVE}/Users/${USERNAME}/OneDrive\ -\ Tandem\ Diabetes\ Care,\ Inc/Desktop"
alias dlo="cd ${CDRIVE}/Users/${USERNAME}/OneDrive\ -\ Tandem\ Diabetes\ Care,\ Inc/Downloads"
alias tools="cd ${CDRIVE}/git/my_tools"

###############################################################################
# linux aliases
###############################################################################
alias ls="ls -p"

###############################################################################
# windows aliases
###############################################################################
alias e="explorer.exe ."

###############################################################################
# windows functions
###############################################################################
# NOTE: The path to putty must be in the environment variables

# "p 30" will start a serial terminal with COM30
p() {
    "putty.exe" "-serial" "COM$@" "-sercfg" "115200,8,n,1,X" &
}

# "pl wombat_fixture" will start a session saved with that name
pl() {
    "putty.exe" "-load" "$@" &
}

###############################################################################
# config file aliases/functions
###############################################################################
# gets the latest config files from the paths specified
refresh() {
    ###########################################################################
    # bashrc
    ###########################################################################
    # copy the .bashrc given by the embedded repo
    cp ${EMBEDDEDCONFIG}/dot_bashrc ~/.bashrc

    # append a custom .bashrc
    if [ -z ${MYBASHRCPATH} ]
    then
        echo "no custom .bashrc path given, skipping"
    else
        cat ${MYBASHRCPATH} >> ~/.bashrc;
        sed -i 's/\r$//g' ~/.bashrc;
    fi

    # use the new .bashrc you just made
    source ~/.bashrc

    ###########################################################################
    # gitconfig
    ###########################################################################
    # copy the .gitconfig given by the embedded repo
    cp ${EMBEDDEDCONFIG}/dot_gitconfig ~/.gitconfig

    # update the .gitconfig with your own preferences
    sed -i "s/Marko Hyvonen/${FULLNAME}/g" ~/.gitconfig
    sed -i "s/mhyvonen/${USERNAME}/g" ~/.gitconfig
    sed -i "s/editor\s=\s.*notepad.*$/ editor = vim/g" ~/.gitconfig
    sed -i "s/\r$//g" ~/.gitconfig

    # append a custom .gitconfig
    if [ -z ${MYGITCONFIGPATH} ]
    then
        echo "no custom .gitconfig path given, skipping"
    else
        cat ${MYGITCONFIGPATH} >> ~/.gitconfig;
        sed -i "s/\r$//g" ~/.gitconfig;
    fi

    ###########################################################################
    # inputrc
    ###########################################################################
    # copy a custom .inputrc
    if [ -z ${MYINPUTRCPATH} ]
    then
        echo "no custom .inputrc path given, skipping"
    else
        cp ${MYINPUTRCPATH} ~/.inputrc;
        sed -i "s/\r$//g" ~/.inputrc;
    fi

    ###########################################################################
    # vimrc
    ###########################################################################
    # copy a custom .vimrc
    if [ -z ${MYVIMRCPATH} ]
    then
        echo "no custom .vimrc path given, skipping"
    else
        cp ${MYVIMRCPATH} ~/.vimrc;
        sed -i "s/\r$//g" ~/.vimrc;
    fi
}

# edit config files
alias ebrc="vim ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias eirc="vim ~/.inputrc"
alias egcf="vim ~/.gitconfig"

# print config files
alias bashrc="cat ~/.bashrc"
alias vimrc="cat ~/.vimrc"
alias inputrc="cat ~/.inputrc"
alias gitconfig="cat ~/.gitconfig"

###############################################################################
# proxies
###############################################################################
#export no_proxy=.ti.com
#export http_proxy=http://webproxy.ext.ti.com:80/
#export https_proxy=https://webproxy.ext.ti.com:80/

##############################################################################
# export aliases
##############################################################################
# export PATH=$PATH:/env_variable_path

# define append_path and prepend_path to add directory paths, e.g. PATH, MANPATH
# add to end of path
append_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=\$$1:$2"
  fi
}

# add to front of path
prepend_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=$2:\$$1"
  fi
}

# Make git bash the default git
export PATH="${CDRIVE}/Program Files/Git/cmd:${PATH}"
# export GITPATH=${CDRIVE}/Program\ Files/Git/cmd
# prepend_path PATH ${GITPATH}

# svn editor
export SVN_EDITOR='vim'

# Override the default IAR paths... can't auto detect on Windows 7.
export TNDM_IAR_EW_ARM_7501_10273='C:\Program Files (x86)\IAR Systems\Embedded Workbench 7.3'
export TNDM_IAR_EW_MSP_430_6201='C:\Program Files (x86)\IAR Systems\Embedded Workbench 7.0'

# Remove path duplicates in PATH
PATH=$(echo $PATH | awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')

# command line info to display
#export PS1+="\e[31m($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \e[91m~\n\e[97m$ "
#export PS1="\e[94m\u@\H \e[96m\w \e[31m($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \e[91m~\n\e[97m$ "

# display git branches in cygwin
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
if [[ $(cat /proc/version | awk '{ print $1 }') =~ CYGWIN|Linux ]]; then
    export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
fi

