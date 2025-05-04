export EDITOR='code --wait'
export EDITOR_NOWAIT='code'
export BAT_STYLE='full'
export BAT_PAGER='less -rRXF'
export GPG_TTY=$(tty)
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press enter to execute, ^Y to copy, ^/ to preview'"
export FZF_CTRL_T_OPTS="--preview 'bat --color always {}' --bind='enter:execute(code {})+abort' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export COPYFILE_DISABLE=1 # so that tar works properly on mac

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.dotfiles/aws/bin:$PATH"
export PATH="$HOME/.dotfiles/contrib/aws/bin:$PATH"
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/bin/openssl:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="$PATH:/usr/local/sbin:/opt/homebrew/sbin"
export MANPATH="/usr/local/man:$MANPATH"

export TZ_LIST="US/Central;US/Eastern;Europe/Warsaw;Japan"

unset JAVA_HOME

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' prefix ''

alias c='code .'
alias v='vi .'
alias vim='nvim'
alias vi='nvim'
alias notes="$EDITOR_NOWAIT $HOME/.notes"
alias obsidian='open /Applications/Obsidian.app'
alias dotfiles="$EDITOR_NOWAIT $HOME/.dotfiles"
alias zshrc="$EDITOR_NOWAIT $HOME/.dotfiles/zsh"
alias maven-cache="open ~/.m2/repository/"
alias gradle-cache="open ~/.gradle/caches/modules-2/files-2.1/"
alias mvn='./mvnw'
alias mvnw='./mvnw'
alias gradle='./gradlew'
alias gradlew='./gradlew'
alias kvers="kgp --no-headers | fzf --reverse --multi --ansi --nth 1 --preview 'kubectl get pods {1} -o json | jq -r \".spec.containers[].image\" | sed \"s/^.*\(\/\)//\" | tr -s \"[:blank:]\"'"
alias kver='kgp --all-namespaces --no-headers -o custom-columns=img:.spec.containers..image,phase:.status.phase | sort | uniq | sed "s/^.*\(\/\)//" | tr -s "[:blank:]" | column -t -s " "'
alias kverw='kgp -w --all-namespaces --no-headers -o custom-columns=img:.spec.containers..image,phase:.status.phase | sed "s/^.*\(\/\)//"'
alias klogs="kgp --no-headers | fzf --reverse --multi --ansi --nth 1 --preview 'kubectl logs --tail=30 {1} | tac | jq -C -R -r \". as \\\$line | try fromjson catch \\\$line\"'"
alias kdelete-evicted='kgp | grep Evicted | awk '"'"'{print $1}'"'"' | xargs kubectl delete pod'
alias la='ls -alh'
alias ls='eza --time-style long-iso --git --icons'
alias ips='ps -e -o user,pid,ppid,pgid,pri,nice,%cpu,%mem,comm'
alias psi='ips | fzf --reverse --multi --ansi'
alias cat='bat'
alias ping='prettyping'
alias top='sudo htop'
alias bri='brew info'
alias bru='brew update && brew upgrade 2>&1 | tee "$HOME/.brew-upgrade.log" && brew upgrade --cask 2>&1 | tee "$HOME/.brew-upgrade-cask.log" && brew cleanup'
alias brug='brew update && brew upgrade --greedy 2>&1 | tee "$HOME/.brew-upgrade.log" && brew upgrade --cask --greedy 2>&1 | tee "$HOME/.brew-upgrade-cask.log" && brew cleanup'
alias ncdu='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias visualvm='/Applications/VisualVM.app/Contents/MacOS/visualvm --jdkhome $JAVA_HOME'
alias jmc='/Applications/JDK\ Mission\ Control.app/Contents/MacOS/jmc -vm $JAVA_HOME/bin'
alias adblock="$HOME/.spotify-xbar/add-current-ad.sh"
alias glg="git log --color=always --decorate=short --oneline | fzf --reverse --multi --ansi --nth 2.. --preview 'git show {+1} | delta' --bind='enter:execute(git show {1})+abort'"
alias gst="git -c color.status=always status --short | fzf --reverse --multi --ansi --nth -1 --preview 'git diff HEAD {-1} | delta' --preview-window=down:85%"
alias ghi="gh issue list | fzf --reverse --multi --ansi --preview 'gh issue view {1} | bat -p -l md --color always' --bind='enter:execute(gh issue view {1} --web)+abort' --preview-window=down:75%"
alias ghpr="gh pr list | fzf --reverse --multi --ansi --preview 'gh pr view {1} | bat -p -l md --color always' --bind='enter:execute(gh pr view {1} --web)+abort' --preview-window=down:75%"

alias hl='h ERROR INFO WARN DEBUG'
alias lzd='lazydocker'
alias trim="awk '{\$1=\$1};1'"
alias wttr="curl 'https://wttr.in/Bellevue?m'"
alias wttr+="curl 'https://v2.wttr.in/Bellevue?m'"
alias moon="curl 'https://wttr.in/Moon'"

alias docker-test='docker run docker/whalesay cowsay Hello World!'
alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-rm-all='docker rm $(docker ps -aq)'
alias docker-rmi-all='docker rmi -f $(docker images -aq)'
alias docker-destroy-all='docker-stop-all && docker-rm-all && docker-rmi-all'

alias print-keystore='keytool -list -v -keystore'
alias print-cert='keytool -printcert -v -file'

function tn() {
	exitCode="$?";
	if [ "$exitCode" -ne 0 ]; then
		msg='Failed';
	else
		msg='Success';
	fi

	noti --title 'Task finished!' --message "$msg";

	return "$exitCode";
}

function docker-rmi() {
	if [ $# -eq 1 ]; then
		docker rmi -f "$(docker images $1 -aq)"
	else
		echo "Usage: $0 <imageName>"
	fi
}

function docker-image-upgrade() {
	docker images | grep ' latest ' | cut -f1 -w | xargs -n1 docker pull
	docker images | grep ' <none> ' | cut -f3 -w | xargs docker rmi
}

function gradle-build-scan-enable() {
	[ -f ~/.gradle/enterprise/keys.properties.bak ] && mv ~/.gradle/enterprise/keys.properties.bak ~/.gradle/enterprise/keys.properties
	[ -f ~/.gradle/develocity/keys.properties.bak ] && mv ~/.gradle/develocity/keys.properties.bak ~/.gradle/develocity/keys.properties
}

function gradle-build-scan-disable() {
	[ -f ~/.gradle/enterprise/keys.properties ] && mv ~/.gradle/enterprise/keys.properties ~/.gradle/enterprise/keys.properties.bak
	[ -f ~/.gradle/develocity/keys.properties ] && mv ~/.gradle/develocity/keys.properties ~/.gradle/develocity/keys.properties.bak
}

function tcc-enable {
	# export DOCKER_HOST=$(docker context inspect tcc | jq -r ".[0].Endpoints.docker.Host")
	docker context use tcc
}

function tcc-disable {
	# export DOCKER_HOST=$(docker context inspect default | jq -r ".[0].Endpoints.docker.Host")
	docker context use default
}

function uao() {
	if [ $# -eq 1 ]; then
		fileName=$(basename -- "$1")
		projectDirName="${fileName%.*}"
		unzip -q "$fileName"
		cd "$projectDirName"
		idea .
	else
		echo "Usage: $0 <file.zip>"
	fi
}

function kg() {
	if [ $# -eq 1 ]; then
		kubectl get $1 --no-headers --all-namespaces | fzf --reverse --multi --ansi --nth 2 --preview "kubectl get $1 {2} --namespace {1} -o yaml | bat -n -l yaml --color always" --preview-window=down:80%
	else
		echo "Usage: $0 <resource>"
	fi
}

function kd() {
	if [ $# -eq 1 ]; then
		kubectl get $1 --no-headers --all-namespaces | fzf --reverse --multi --ansi --nth 2 --preview "kubectl describe $1 {2} --namespace {1} | bat -n -l yaml --color always" --preview-window=down:80%
	else
		echo "Usage: $0 <resource>"
	fi
}

function ke() {
	pod=$(kgpa | fzf --reverse --ansi --query="$@" | awk '{print $2}')
	if [ ! -z "$pod" ]; then
		echo # so that remote prompt appears
		kubectl exec -it "$pod" -- /bin/bash
	fi
}

function kipf() {
	if [ $# -eq 2 ]; then
		kubectl exec -it $1 -- /bin/bash -c "apt-get update && apt-get install -y socat"
		kubectl port-forward $1 $2
	else
		echo "Usage: $0 <pod> <port-mapping>"
	fi
}

function which-nodes() {
	if [ $# -eq 1 ]; then
		kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name --all-namespaces --no-headers | grep $1
	else
		kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name --all-namespaces --no-headers
	fi
}

function which-nodesi() {
	nodes=''
	if [ $# -eq 1 ]; then
		nodes=$(which-nodes $1)
	else
		nodes=$(which-nodes)
	fi

	echo $nodes | fzf --reverse --multi --ansi --preview 'kubectl get pods --all-namespaces -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name | grep {1} | tr -s " " | cut -f2 -d" "'
}

function kchaos() {
	if [ $# -eq 2 ]; then
		kubectl get pod -o=custom-columns=NAME:.metadata.name,NODE:.spec.nodeName --no-headers | grep -v -E "$(which-nodes $1 | cut -f1 -d' ' | paste -sd '|' -)" | grep deployment | shuf | head -n$2 | cut -f1 -d' ' | xargs kubectl delete pod
	else
		echo "Usage: $0 <pod name pattern to protect> <number of pods to delete>"
	fi
}

function git-sync() {
	git pull upstream "$(git branch --show-current)"
}

function git-branch-and-worktree() {
	if [ $# -eq 1 ]; then
		git branch "$1"
		git worktree add "code/$1" "$1"
	else
		echo "Usage: $0 <branch>"
	fi
}

function git-rename {
	if [ $# -eq 0 ]; then
		git-rename master main
	elif [ $# -eq 2 ]; then
		git branch -m "$1" "$2"
		git fetch origin
		git branch -u origin/"$2" "$2"
		git remote set-head origin -a
	else
		echo "Usage: $0 [<branch-from> <branch-to>]"
	fi
}

function gitignore() {
	api="curl -L -s https://www.gitignore.io/api"
	if [ "$#" -eq 0 ]; then
		result="$(eval "$api/list" | tr ',' '\n' | fzf --reverse --multi --preview "$api/{} | bat -n -l gitignore --color always" | paste -s -d "," -)"
		[ -n "$result" ] && eval "$api/$result"
	else
		eval "$api/$*"
	fi
}

function full-repo-review {
	# Creating an empty branch with no history
	git checkout --orphan code-review
	git rm -r --cached '*'
	git clean -fxd

	# Empty commit so we will have some history
	git commit --allow-empty -m "Emptyness for review"
	# Creating another branch which shares the same history
	git branch empty

	# Merge main to code-review, push and we can create a PR from code-review to empty
	git merge main --allow-unrelated-histories
	git push origin code-review
	git push origin empty
}

function kms-encrypt() {
	if [ $# -eq 2 ]; then
		aws kms encrypt --key-id $1 --plaintext $2 --output text --query CiphertextBlob
	else
		echo "Usage: $0 <keyID> <plaintext>"
	fi
}

function kms-decrypt() {
	if [ $# -eq 1 ]; then
		aws kms decrypt --ciphertext-blob fileb://<(echo $1 | base64 --decode) --output text --query Plaintext | base64 --decode
	else
		echo "Usage: $0 <ciphertext> (base64 encoded, as is from encrypt)"
	fi
}

function fbn() {
	if [ $# -eq 1 ]; then
		find . -name $1
	elif [ $# -eq 2 ]; then
		find $1 -name $2
	else
		echo "Find by Name, usage: $0 [path] \"<fileNamePattern>\""
		echo "e.g.: fbn . \"*.java\""
	fi
}

function fbc() {
	if [ $# -eq 1 ]; then
		grep $1 -r .
	elif [ $# -eq 2 ]; then
		grep $1 -r . --include=$2
	else
		echo "Find by Content, usage: $0 <query> [\"fileNamePattern>\"]"
		echo "e.g.: fbc HashMap \"*.java\""
	fi
}

function killpidof() {
	if [ $# -eq 1 ]; then
		sudo kill `pidof $1`
	else
		echo "Usage: $0 <commandName>"
	fi
}

function cmdof() {
	if [ $# -eq 1 ]; then
		ps ax | grep $1
	else
		echo "Usage: $0 <commandName>"
	fi
}

function wholistens() {
	sudo lsof -PiTCP -sTCP:LISTEN
}

function docker-exec-debug() {
	if [ $# -eq 1 ]; then
		docker exec -it $1 sh
	else
		echo "Usage: $0 <imageID>"
	fi
}

function docker-run-debug() {
	if [ $# -eq 1 ]; then
		docker run -it --entrypoint sh $1
	else
		echo "Usage: $0 <containerID>"
	fi
}

function bigfiles() {
	du -sh * | gsort -rh | head -n10
}

function showHiddenFiles() {
	hiddenFiles YES
}

function hideHiddenFiles() {
	hiddenFiles NO
}

function hiddenFiles() {
	if [ $# -eq 1 ]; then
		defaults write com.apple.finder AppleShowAllFiles $1 && killall Finder
	else
		echo "Usage: $0 YES / $0 NO"
	fi
}

function print-colors() { # colors is occupied by zinit (zinit self-update uses it)
	for i in {0..255} ; do
		printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
		if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
			printf "\n";
		fi
	done
}

function random() {
	if [ $# -eq 1 ]; then
		head /dev/random | base64 | head -c $1
	else
		echo "Usage: $0 <lenght>"
	fi
}

function release-notes() {
	if [ $# -eq 1 ]; then
		git log $1 --pretty=oneline | cat | grep -E 'Merge pull request .*|.*\(#\d+\).*' | cut -d' ' -f 2-
	else
		echo "Usage: $0 <revision range>"
		echo "$0 450d8c9...561d5bf"
		echo "$0 450d8c9...main"
		echo "$0 450d8c9...HEAD"
		echo "$0 1.5.x...main"
		echo "$0 1.5.0...1.5.1"
	fi
}

function pwdless() {
	if [ "$#" != 1 ]; then
		echo "Usage: $0 hostname"
	else
		echo "Setting up $1"
		cat ~/.ssh/id_rsa.pub | ssh $1 'install -D /dev/stdin ~/.ssh/authorized_keys'
	fi
}

function key-fingerprint() {
	if [ "$#" != 1 ]; then
		echo "Usage: $0 <key file path>"
	else
		openssl pkcs8 -in $1 -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
	fi
}

function watch-http() {
	if [ "$#" -eq 1 ]; then
		watch http --verbose --pretty=format "$1";
	elif [ "$#" -eq 2 ]; then
		watch "$1" http --verbose --pretty=format "$2";
	else
		echo "Usage: $0 [\"<watch-args>\"] \"<httpie-args>\""
		echo "Examples:"
		echo "\t$0 :8080"
		echo "\t$0 '-n1' ':8080'"
	fi
}

# ncat --listen --keep-open --verbose --source-port 8080 --sh-exec 'tee /dev/tty | echo HTTP/1.1 200 OK\\r\\nContent-Length: 19\\r\\n\\r\\n$(date "+%F %T")'
function wiretap() {
	if [ "$#" -eq 0 ]; then
		wiretap 8080
	elif [ "$#" -eq 1 ]; then
		echo "Listening on port $1"
		/usr/bin/nc -kl $1
	else
		echo "Usage: $0 [port]"
	fi
}

function connection-test() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <SERVER_TO_PING>";
	else
		ping -c 1 $1 #>> /dev/null 2>&1
	fi
}

function sslscan-nmap() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <hostname>";
	else
		nmap --script ssl-enum-ciphers -p 443 $1
	fi
}

function sslscan-openssl() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <hostname>";
	else
		openssl s_client -connect $1:443 <<< 'GET /'
	fi
}

function cert-check {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <hostname>";
	else
		rs=$(openssl s_client -connect $1:443 <<< 'GET /' 2>&1)
		exitCode="$?";
		if [ "$exitCode" -ne 0 ]; then
			echo "$rs"
			return "$exitCode"
		fi

		rs=$(echo "$rs" | grep ' s:\| i:' | cut -c 2-)
		echo "$rs"

		case "$rs" in
			*SSL-SG1-GLOBAL*) return 1;;
			*lvnpano01*) return 1;;
			*) return 0;;
		esac
	fi
}

function cert-check-all {
	SITES=('google.com' 'mail.google.com' 'chat.google.com' 'meet.google.com' 'youtube.com' 'facebook.com' 'instagram.com' 'x.com' 'twitter.com' 'bsky.app' 'wikipedia.org' 'yahoo.com' 'reddit.com' 'amazon.com' 'chatgpt.com' 'tiktok.com' 'netflix.com' 'dropbox.com' 'linkedin.com' 'duckduckgo.com' 'discord.com' 'slack.com' 'github.com' 'stackoverflow.com' 'search.maven.org' 's01.oss.sonatype.org' 'services.gradle.org' 'example.org')
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m'
	for SITE in $SITES
	do
		if [ "$1" = '--verbose' ]; then
			out=$(cert-check "$SITE" 2>&1)
			[ "$?" = 0 ] && echo -e "${GREEN}${SITE}: OK${NC}" || echo -e "${RED}${SITE}: Failed${NC}"
			echo "$out"
		else
			cert-check "$SITE" 2>&1 > /dev/null
			[ "$?" = 0 ] || echo "${SITE}: Failed"
		fi
	done
}

function firewall-check {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <hostname>";
	else
		rs=$(curl --silent --show-error --show-headers --location --fail --user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' --header 'Sec-Fetch-Site: none' "$1" 2>&1);
		exitCode="$?";
		echo "$rs" | grep --text '^HTTP\/\|^curl: ';
		if [ "$exitCode" -ne 0 ]; then
			return "$exitCode";
		fi
	fi
}

function firewall-check-all {
	SITES=('https://google.com' 'https://mail.google.com' 'https://chat.google.com' 'https://meet.google.com' 'https://youtube.com' 'https://www.facebook.com' 'https://instagram.com' 'https://x.com' 'https://twitter.com' 'https://bsky.app' 'https://wikipedia.org' 'https://yahoo.com' 'https://reddit.com' 'https://www.amazon.com' 'https://chatgpt.com' 'https://tiktok.com' 'https://netflix.com' 'https://dropbox.com' 'https://linkedin.com' 'https://duckduckgo.com' 'https://discord.com' 'https://slack.com' 'https://github.com' 'https://stackoverflow.com' 'https://search.maven.org' 'https://s01.oss.sonatype.org:443' 'https://services.gradle.org' 'https://example.org' 'https://1.1.1.1/help')
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m'
	for SITE in $SITES
	do
		if [ "$1" = '--verbose' ]; then
			out=$(firewall-check "$SITE" 2>&1)
			[ "$?" = 0 ] && echo -e "${GREEN}${SITE}: OK${NC}" || echo -e "${RED}${SITE}: Failed${NC}"
			echo "$out"
		else
			firewall-check "$SITE" 2>&1 > /dev/null
			[ "$?" = 0 ] || echo "${SITE}: Failed"
		fi
	done
}

function http-serv() {
	if [ $# -eq 1 ]; then
		www_dir='/tmp/www'
		mkdir -p $www_dir && echo 'Hello World!' > $www_dir/index.html
	elif [ $# -eq 2 ]; then
		www_dir=$2
	else
		echo "Usage: $0 <port> [directory]"
		return 1;
	fi
	echo "Starting HTTP Server listening on port $1, serving directory: $www_dir"
	pushd $www_dir
	python3 -m http.server $1
	popd
	unset www_dir
}

function https-serv() {
	if [ $# -eq 1 ]; then
		www_dir='/tmp/www'
		mkdir -p $www_dir && echo 'Hello World!' > $www_dir/index.html
	elif [ $# -eq 2 ]; then
		www_dir=$2
	else
		echo "Usage: $0 <port> [directory]"
		return 1;
	fi

	echo "Starting HTTP Server listening on port $1, serving directory: $www_dir"
	pushd $www_dir
	openssl req -new -x509 -subj '/CN=localhost/O=localhost/C=US' -days 365 -nodes -keyout server.pem -out server.pem
	python3 - <<EOF
import http.server, ssl
httpd = http.server.HTTPServer(('localhost', $1), http.server.SimpleHTTPRequestHandler)
sslctx = ssl.SSLContext(ssl.PROTOCOL_TLS)
sslctx.check_hostname = False
sslctx.load_cert_chain(certfile='./server.pem')
httpd.socket = sslctx.wrap_socket(httpd.socket, server_side=True)
httpd.serve_forever()
EOF
	popd
	unset www_dir
}

function ssh-tunnel() {
	if [ "$#" -ne 2 ]; then
		echo "Usage: $0 <local-port> <host:port>";
	else
		hostAndPort=($(echo $2 | sed 's/:/ /g'))
		ssh -L $1:$hostAndPort[1]:$hostAndPort[2] -Nf $USERNAME@192.168.0.1 # change server you want the tunnel to go through
	fi
}

function me() {
	curl -s cli.fyi/me
}

function myip() {
	echo "local: $(mylocalip)"
	echo "public: $(mypublicip)"
}

function mylocalip() {
	ipconfig getifaddr en1 || ipconfig getifaddr en0
}

function mypublicip() {
	curl -s 'https://ifconfig.io'
}

function fyi() {
	api="curl -L -s -k https://cli.fyi"
	if [ "$#" -eq 0 ]; then
		result="$(eval "$api/help" | jq -r '.data | to_entries | .[] | .key + " - " + .value.example' | fzf --reverse --multi --preview "echo {} | cut -d'-' -f2- | xargs -n1 curl -L -s -k | jq -C")"
		[ -n "$result" ] && echo $result | cut -d'-' -f2- | xargs -n1 curl -L -s -k | jq -C
	else
		eval "$api/$*" | jq
	fi
}

function randomMAC() {
	# https://github.com/feross/spoof
	spoof list --wifi
	echo 'Randomizing MAC...'
	sudo spoof randomize wi-fi
	spoof list --wifi
}

function restoreMAC() {
	spoof list --wifi
	echo 'Restoring MAC...'
	sudo spoof set `cat $HOME/.sec/mac` wi-fi
	spoof list --wifi
}

function gradleVersion() {
	curl -s https://services.gradle.org/versions/current | jq '.version' --raw-output
	# groovy -e "println new groovy.json.JsonSlurper().parseText('https://services.gradle.org/versions/current'.toURL().text).version"
}

function gradlewUpdate() {
	./gradlew wrapper --gradle-version `gradleVersion`
}

function lock-update() {
	if [ "$#" -eq 0 ]; then
		./gradlew resolveAndLockAll --write-locks
	else
		./gradlew resolveAndLockAll --update-locks "$@"
	fi

	git status
}

function native-image-install {
	rm ~/.asdf/shims/*
	asdf reshim
	gu install native-image
	asdf reshim
}

function clipboard-fix() {
	echo 'restarting clipboard services...'
	killall pbs
	killall pboard
	launchctl start com.apple.pboard
	launchctl start com.apple.pbs
	killall Finder
	echo 'please restart your apps'
}

function dns-flush() {
	sudo dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
}

function dns-setup() {
	services=$(networksetup -listallnetworkservices | grep 'Wi-Fi\|Ethernet\|USB')
	while read -r service; do
		echo "Setting DNS for $service"
		networksetup -setdnsservers "$service" '1.1.1.2' '1.0.0.2' '1.1.1.1' '1.0.0.1' '2606:4700:4700::1111' '2606:4700:4700::1001'
	done <<< "$services"
}

function dns-reset() {
	services=$(networksetup -listallnetworkservices | grep 'Wi-Fi\|Ethernet\|USB')
	while read -r service; do
		echo "Resetting DNS for $service"
		networksetup -setdnsservers "$service" empty
	done <<< "$services"
}

function quarantine-fix {
	if [ "$#" -ne 1 ]; then
		echo "Usage: $0 <app-path>";
	else
		xattr -rd com.apple.quarantine "$1"
	fi
}

function menubar-fix {
	# because of the notch, menu bar items can be hidden, this decreases space between them
	defaults -currentHost write -globalDomain NSStatusItemSpacing -int 4
	defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 2
	killall SystemUIServer

	# read current values
	# defaults -currentHost read -globalDomain NSStatusItemSpacing
	# defaults -currentHost read -globalDomain NSStatusItemSelectionPadding

	# reset values
	# defaults -currentHost delete -globalDomain NSStatusItemSpacing
	# defaults -currentHost delete -globalDomain NSStatusItemSelectionPadding
	# killall SystemUIServer
}

function managedclient-fix {
	sudo kill -9 $(pidof ManagedClient)
	sleep 3
	sudo kill -STOP $(pidof ManagedClient)
}

function vscode-fix {
	codesign --force --deep --sign - '/Applications/Visual Studio Code.app'
}

function vpn-enable {
	launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
}

function vpn-disable {
	launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
}

function onguard-enable {
	sudo launchctl load /Library/LaunchDaemons/com.arubanetworks.*
	open '/Applications/Aruba Networks/ClearPass OnGuard.app'
}

function onguard-disable {
	sudo launchctl unload /Library/LaunchDaemons/com.arubanetworks.*
	sudo kill -9 "$(pgrep 'ClearPass OnGuard')"
}

function wss-disable {
	launchctl unload /Library/LaunchAgents/com.symantec.wssa.uix.plist
	sudo kill -9 "$(pgrep 'com.symantec.wssa.wssax')"
}

function startup-fix {
	vpn-disable
	onguard-disable
	wss-disable
}

# launchctl unload /Library/LaunchDaemons/com.symantec.symdaemon.*plist
# com.airwatch.airwatchd.plist
# com.airwatch.awcmd.plist

function update() {
	echo 'zsh upgrade...'
	"$ZSH/tools/upgrade.sh"

	echo 'zinit update...'
	zinit self-update
	zinit update --parallel

	echo 'brew update, upgrade, cleanup...'
	brew update
	brew upgrade # --greedy
	brew upgrade --cask
	brew cleanup

	echo 'tldr update...'
	tldr --update

	echo 'cheatsheets update...'
	git -C "$HOME/.config/cheat/cheatsheets/community" pull

	echo 'asdf plugin update...'
	asdf plugin update --all

	echo 'npm update...'
	npm update npm -g && npm update -g

	echo 'softwareupdate update...'
	softwareupdate -i -a
}

function install-completions() {
	# first create completion file, e.g.: kind completion zsh > /usr/local/share/zsh/site-functions/_kind
	autoload -U compinit && compinit
}

function brew-link-fix {
	brew link --overwrite docker
	brew link --overwrite docker-completion
	brew link --overwrite docker-compose

	rm /usr/local/bin/gpg2
	ln -s /usr/local/bin/gpg /usr/local/bin/gpg2
}

function demo-init() {
	cp -r "$HOME/.dotfiles/demo-initializer/." .
	git init
	git add .
	git commit -m 'initial demo project'
}

function gh-sso() {
	orgs=$(gh api -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' '/user/memberships/orgs' | jq -r '.[].organization.login')
	while read -r org; do
		curl --silent --location --fail "https://github.com/orgs/$org/sso" > '/dev/null'
		if [ "$?" -eq 0 ]; then
			open "https://github.com/orgs/$org/sso"
		fi
	done <<< "$orgs"
}
