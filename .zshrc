#######################################################################################
# HERE YOU CAN WRITE YOUR OWN STUFF. IT WILL BE APPENDED TO .zshrc WHEN `make install``
#######################################################################################

# git
alias gpull='git pull origin $(git symbolic-ref --short HEAD)'
alias gpush='git push origin $(git symbolic-ref --short HEAD)'
alias gst='git status'
alias grestore='git reset --soft HEAD~1 && git restore --staged .'
alias gupdate='gpull --ff-only && git fetch'

# tempalte setupper
alias setup='~/.templates/setupTemplate.sh'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

clear