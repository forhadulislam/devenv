## If proxy is set then update and upgrade the system.
apt-get update -y
apt-get -y upgrade
apt-get install -y software-properties-common apt-transport-https wget

rm -rf /usr/local/go # Delete the previous version
cd /tmp
wget https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz

### open ~/.profile file and add these following 3 lines.

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

##  Save it after that.

## Reload the .profile module
. ~/.profile

## Install git and git review
apt-get install -y git
apt-get install -y git-review


cp /app/gitconfig ~/.gitconfig

# Add VS Code
sudo snap install --classic code


# Node 

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install gcc g++ make
sudo apt install nodejs
sudo apt install build-essential


### Verify the versions of the installed components
git --version
go version
go env
code --version
java -version
cat /etc/environment
cat ~/.gitconfig

