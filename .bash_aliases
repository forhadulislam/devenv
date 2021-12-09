UROOT="/home/sadi"
WORKDIR="${UROOT}/Work"
INVENTORY="${WORKDIR}/inventory/"

alias update="sudo apt update"
alias upinventory="git -C $INVENTORY pull"
alias sshc="${INVENTORY}/resources/ssh_inv"

function fail {
  echo $1 >&2
  exit 1
}

function findFreePort {
    BASE=${BASE:-22222} #BASE_PORT
    INCREMENT=1
    port=$BASE
    isfree=$(netstat -taln | grep $port)
    while [[ -n "$isfree" ]]; do
        port=$[port+INCREMENT]
        isfree=$(netstat -taln | grep $port)
    done
    echo "Usable Port: $port"
}

function goUpdate {
  if [[ -z "$1" ]]; then
    echo "Provide a valid Go version!"
    return 1
  fi
  echo "Updating Go version to $1"
  CURRENT_GO_VERSION=$(go version | cut -d' ' -f3 | cut -c3-)
  echo "Current Go version is $CURRENT_GO_VERSION"
  if awk "BEGIN {exit !($CURRENT_GO_VERSION > $1)}"; then
    echo "Cannot downgrade Go version from $CURRENT_GO_VERSION to $1"
    return 1
  fi
  GO_DOWNLOAD_URL="https://golang.org/dl/go${1}.linux-amd64.tar.gz"
  wget -q --spider $GO_DOWNLOAD_URL
  if [[ $? -gt 0 ]]; then
    echo "Cannot download Go version: $1 from $GO_DOWNLOAD_URL"
    return 1
  fi

  sudo rm -rf /usr/local/go # Delete the previous version
  cd /tmp

  echo "Downloading from: $GO_DOWNLOAD_URL"
  sudo wget $GO_DOWNLOAD_URL
  sudo tar -C /usr/local -xzf go${1}.linux-amd64.tar.gz
}

function retry {
  local n=1
  local max=${MAX:-50}
  local delay=${DELAY:-3}
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $delay;
      else
        echo "The command has failed after $n attempts."
	exit 1
      fi
    }
  done
}

