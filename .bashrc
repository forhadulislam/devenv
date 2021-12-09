alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
#export PATH=${PATH}:${GOPATH}/bin
#export PATH=${PATH}:$HOME/sonar-scanner/bin
export PATH=/usr/local/pact/bin:$PATH



if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi 
