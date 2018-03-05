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
alias gl="git log"
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

###############################################################################
# cd aliases
###############################################################################
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd /c/git"
alias ble="cd /c/git/ble"
alias bletest="cd /c/git/ble_test"
alias oad="cd /c/git/ble_test/scripts/OAD_Automation"
alias ascript="cd /c/git/athena/scripts"
alias custom="cd /c/git_mine/"
alias desktop="cd /c/Users/sdTest/Desktop"
alias current="cd /c/git/lpc_env/15-4keyexchange"
alias mytools="cd /c/my_git/my_tools"

###############################################################################
# windows aliases
###############################################################################
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
alias ebashrc="subl ~/.bashrc"
alias bashrc="cat ~/.bashrc"

###############################################################################
# proxies
###############################################################################
export no_proxy=.ti.com
export http_proxy=http://webproxy.ext.ti.com:80/
export https_proxy=https://webproxy.ext.ti.com:80/
