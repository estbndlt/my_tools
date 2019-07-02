###############################################################################
# git aliases
###############################################################################
alias g="git"
alias ga="git add"
alias gs="git status"
alias gf="git fetch"
alias gb="git branch"
alias gbav="git branch -avv"
alias gm="git merge"
alias gp="git pull"
alias gpod="git pull origin develop"
alias gl="git log --all --decorate --oneline --graph"
alias gpp="git push"
alias gcm="git commit -m"
alias grh="git reset --hard"
alias gc="git clean -dxf"
alias gcr="git clean -dxf && git reset --hard"
alias gsp="git stash pop"
alias gsl="git stash list"
alias gss="git stash save"
alias gsa="git stash apply"
alias gsd="git stash drop"
alias gst="git stash"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcod="git checkout develop"
alias gcot="git checkout --track"
alias gus="git reset HEAD --"
# git assume unchanged

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
# cd aliases
###############################################################################
# get the right c drive prefix
if [[ $(cat /proc/version | awk '{ print $1 }') =~ CYGWIN ]]; then
    export CDRIVE='/cygdrive/c'
elif [[ $(cat /proc/version | awk '{ print $1 }') =~ MINGW ]]; then
    export CDRIVE='/c'
elif [[ $(cat /proc/version | awk '{ print $1 }') =~ Linux ]]; then
    export CDRIVE='/mnt/c'
fi

# save the username
export USERNAME='edelatorre'

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# repos
alias ghome="cd ${CDRIVE}/git"
alias shome="cd ${CDRIVE}/svn"

# custom paths
alias dev="cd ${CDRIVE}/svn/dev"
alias devb="cd ${CDRIVE}/svn/dev_branches"
alias dt="cd ${CDRIVE}/Users/${USERNAME}/Desktop"
alias dl="cd ${CDRIVE}/Users/${USERNAME}/Downloads"
alias dto="cd ${CDRIVE}/Users/${USERNAME}/OneDrive\ -\ Tandem\ Diabetes\ Care,\ Inc/Desktop"
alias dlo="cd ${CDRIVE}/Users/${USERNAME}/OneDrive\ -\ Tandem\ Diabetes\ Care,\ Inc/Downloads"
alias tools="cd ${CDRIVE}/git/my_tools"
alias btool="cd ${CDRIVE}/git/britool"
alias qmk="cd ${CDRIVE}/git/qmk_firmware"

###############################################################################
# linux aliases
###############################################################################
alias ls="ls -p"

###############################################################################
# windows aliases
###############################################################################
alias e="explorer ."

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
# print help
###############################################################################
alias refresh=". ~/.bashrc"
alias ebrc="vim ~/.bashrc"
alias bashrc="cat ~/.bashrc"
alias evrc="vim ~/.vimrc"
alias vimrc="cat ~/.vimrc"

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

# svn editor
export SVN_EDITOR='vim'

# Override the default IAR paths... can't auto detect on Windows 7.
export TNDM_IAR_EW_ARM_7501_10273='C:\Program Files (x86)\IAR Systems\Embedded Workbench 7.3'
export TNDM_IAR_EW_MSP_430_6201='C:\Program Files (x86)\IAR Systems\Embedded Workbench 7.0'

# command line info to display
#export PS1+="\e[31m($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \e[91m~\n\e[97m$ "
#export PS1="\e[94m\u@\H \e[96m\w \e[31m($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \e[91m~\n\e[97m$ "

# display git branches in cygwin
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
if [[ $(cat /proc/version | awk '{ print $1 }') =~ CYGWIN ]]; then
    export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
fi
