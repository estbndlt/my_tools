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
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd /c/git"
alias dt="cd /c/Users/edelatorre/Desktop"
alias dl="cd /c/Users/edelatorre/Downloads"
alias dto="cd /c/Users/edelatorre/OneDrive - Tandem Diabetes Care, Inc/Desktop"
alias dlo="cd '/c/Users/edelatorre/OneDrive - Tandem Diabetes Care, Inc/Downloads'"
alias current="cd /c/git/lpc_env/15-4keyexchange"
alias tools="cd /c/git/my_tools"

###############################################################################
# windows aliases
###############################################################################
alias vv="'/c/Program Files (x86)/Vim/vim81/vim.exe'"
alias e="explorer ."
# sublime alias
# atom alias

###############################################################################
# windows functions
###############################################################################
p() {
    "C:\Program Files\PuTTY\putty.exe" "-serial" "COM$@" &
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
