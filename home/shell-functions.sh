# -*- mode: sh -*-
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias fixdisplay='eval $(tmux showenv -s DISPLAY)'
alias ec='open -a /Applications/Emacs.app'
alias cdr='cd `git root`'
alias ls='ls --color=auto'

[ "$TERM" = "xterm-kitty" ] && alias devbox='kitty +kitten ssh devbox'

alias k=kubecolor
#compdef kubecolor=kubectl

alias fast_scp='rsync -avP'
alias docker_clean='docker rm $(docker ps -a -q); docker images -f 'dangling=true' -q | xargs docker rmi'
alias docker_pause='docker pause $(docker ps --quiet)'
alias docker_unpause='docker unpause $(docker ps --quiet)'
alias urldecode='python3 -c "import sys, urllib.parse as parse; \
	print(parse.unquote(sys.argv[1]))"'

alias urlencode='python3 -c "import sys, urllib.parse as parse; \
	print(parse.urlencode(sys.argv[1]))"'

if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
    export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
    # alias emacs="$EMACS -nw"
fi

if [ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]; then
    alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
fi

setup-host () {
	  ssh $1 -- sudo install -o $USER -g amazon -d /home/$USER
    fast_scp /Users/$USER/workplace/EdgeHomes/src/EdgeHomes/home/$USER/*(D) "$1":
    TERM=xterm-kitty kitten ssh $1
}
alias kssh='TERM=xterm-kitty kitten ssh'


function gitclean() {
  git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}


function imix_test() {
  iex -S mix test $1 --trace
}

function k_exec() {
  # https://github.com/kubernetes/kubernetes/issues/8876#issuecomment-715932997 Could do this but wouldn't do it for statefulsets
  po=$(kubectl get po -o custom-columns=':metadata.name' | grep $1 | head -n 1)
  echo exec\'ing into pod "$po"
	kubectl exec -it $po -- "${@:2}"
}
function k_logs() {
 po=$(kubectl get po -o custom-columns=':metadata.name' | grep $1 | head -n 1)
  echo logs from pod "$po"
	kubectl logs -f --tail 100 $po "${@:2}"
}
function lal() {
	ls -alh `which $1`
}

function port() {
  sudo lsof -PiTCP -sTCP:LISTEN | head -n 1
  sudo lsof -PiTCP -sTCP:LISTEN | grep $1
}

function port_pid() {
	sudo netstat -nlp | grep $1 | awk -F ' ' '{print $7}' | cut -d '/' -f 1
}
function sshdetails() {
	grep $1 ~/.ssh/* -ri -A 7
}
function list() {
	ps aux | head -n 1
	ps aux | grep -v grep | grep -i $1
}
function cdls() {
	cd $1
	ls
}
function list_kill(){
	# Can send specific signals, e.g. list_kill com.docker.hyperkit -STOP
	list $1 | sed -n 2p | awk -F ' ' '{print $2}' | xargs kill "${@:2}"
}
function local_tunnel() {
	# https://unix.stackexchange.com/a/115906
	local_port=$1
	remote_host=$2
	remote_port=$3
	ssh -fNL 0.0.0.0:"$local_port:127.0.0.1:$remote_port" $remote_host
}
function remote_tunnel() {
	  local_port=$1
	  remote_host=$2
	  remote_port=$3
	  ssh -fNR 0.0.0.0:"$local_port:127.0.0.1:$remote_port" $remote_host
}
function config {
	  git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
# function realpath() {
# 	nix-shell -p coreutils --run "realpath $@"
# }

function magit () {
    git_root=$(git rev-parse --show-toplevel)
    emacsclient -a emacs \
        -e "(magit-status \"${git_root}\")"
    if [[ -f `which osascript` ]]; then
        osascript -e "tell application \"Emacs\" to activate"
    fi
}

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}
export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd
alias ncp="cat ${NNN_SEL:-${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection} | tr '\0' '\n'"

export MIX_HOME="$HOME/mix"
export ERL_AFLAGS="-kernel shell_history enabled"
export HOMEBREW_AUTO_UPDATE_SECS=604800

