###############################################################################
# git aliases
###############################################################################
alias g="git"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gdom="git diff origin/master"
alias gf="git fetch --prune"
alias gr="git rebase"
alias grom="git rebase --ignore-date origin/master"
alias gb="git branch"
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
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gcot="git checkout --track"

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
    git lg ^origin/master "$1"
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
# print help
###############################################################################
alias refresh="cp ${CDRIVE}/git/embedded/scm/git/config/win_git_bash/dot_bashrc ~/.bashrc;\
cat ${CDRIVE}/git/my_tools/config/.bashrc >> ~/.bashrc;\
sed -i 's/\r$//g' ~/.bashrc;\
source ~/.bashrc;\
cp ${CDRIVE}/git/embedded/scm/git/config/win_git_bash/dot_gitconfig ~/.gitconfig;\
sed -i 's/Marko Hyvonen/Esteban de la Torre/g' ~/.gitconfig;\
sed -i 's/mhyvonen/edelatorre/g' ~/.gitconfig;\
sed -i 's/nano/vim/g' ~/.gitconfig;\
cp ${CDRIVE}/git/my_tools/config/.inputrc ~/.inputrc;\
cp ${CDRIVE}/git/my_tools/config/.vimrc ~/.vimrc;"
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
if [[ $(cat /proc/version | awk '{ print $1 }') =~ CYGWIN|Linux ]]; then
    export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
fi

