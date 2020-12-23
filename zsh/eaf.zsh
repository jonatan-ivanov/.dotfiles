export EDITOR='code --wait'
export EDITOR_NOWAIT='code'
export BAT_STYLE='full'
export BAT_PAGER='less -rRXF'
export GPG_TTY=$(tty)
export FZF_CTRL_T_OPTS="--bind='enter:execute(code {})+abort' --preview 'bat --color \"always\" {}'"
export COPYFILE_DISABLE=1 # so that tar works properly on mac

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"
export MANPATH="/usr/local/man:$MANPATH"

unset JAVA_HOME

alias c='code .'
alias v='vi .'
alias vim='nvim'
alias vi='nvim'
alias dotfiles="$EDITOR_NOWAIT $HOME/.dotfiles"
alias zshrc="$EDITOR_NOWAIT $HOME/.dotfiles/zsh"
alias hyper-conf="$EDITOR_NOWAIT $HOME/.dotfiles/hyper/.hyper.js"
alias mvnw='./mvnw'
alias gradlew='./gradlew'
alias la='ls -alh --git'
alias ls='exa'
alias ips='ps -e -o user,pid,ppid,pgid,pri,nice,%cpu,%mem,comm'
alias psi='ips | fzf --reverse --multi --ansi'
alias cat='bat'
alias ping='prettyping'
alias top='sudo htop'
alias bri='brew info'
alias ncdu='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias visualvm="/Applications/VisualVM.app/Contents/MacOS/visualvm"
alias glg="git log --color=always --decorate=short --oneline | fzf --reverse --multi --ansi --nth 2.. --preview 'git show {+1} | delta --theme=ansi-dark'"
alias gst="git -c color.status=always status --short | fzf --reverse --multi --ansi --nth -1 --preview 'git diff {-1} | delta --theme=ansi-dark'"
alias hl='h ERROR INFO WARN DEBUG'
alias lzd='lazydocker'
alias trim="awk '{\$1=\$1};1'"
alias wttr="curl 'https://wttr.in/Bellevue?m'"
alias wttr+="curl 'https://v2.wttr.in/Bellevue?m'"
alias moon="curl 'https://wttr.in/Moon'"

alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-rm-all='docker rm $(docker ps -aq)'
alias docker-rmi-all='docker rmi -f $(docker images -aq)'
alias docker-destroy-all='docker-stop-all && docker-rm-all && docker-rmi-all'

alias print-keystore='keytool -list -v -keystore'
alias print-cert='keytool -printcert -v -file'

function git-sync() {
    if [ $# -eq 1 ]; then
        git fetch upstream && git checkout $1 && git merge upstream/$1
    else
        echo "Usage: $0 <branch>"
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

function colors() {
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

function pwdless() {
    if [ "$#" != 1 ];then
        echo "Usage: $0 hostname"
    else
        echo "Setting up $1"
        cat ~/.ssh/id_rsa.pub | ssh $1 'install -D /dev/stdin ~/.ssh/authorized_keys'
    fi
}

function key-fingerprint() {
    if [ "$#" != 1 ];then
        echo "Usage: $0 <key file path>"
    else
        openssl pkcs8 -in $1 -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
    fi
}

function connection-test() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <SERVER_TO_PING>";
    else
        ping -c 1 $1 #>> /dev/null 2>&1
    fi
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
    python -m SimpleHTTPServer $1
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
    openssl req -new -x509 -subj '/CN=Unknown/O=Unknown/C=US' -days 365 -nodes -keyout server.pem -out server.pem
    python - <<EOF
import BaseHTTPServer, SimpleHTTPServer, ssl
httpd = BaseHTTPServer.HTTPServer(('localhost', $1), SimpleHTTPServer.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket (httpd.socket, certfile='./server.pem', server_side=True)
httpd.serve_forever()
EOF
    popd
    unset www_dir
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
    api="curl -L -s https://cli.fyi"
    if [ "$#" -eq 0 ]; then
        result="$(eval "$api/help" | jq -r '.data | to_entries | .[] | .key + " - " + .value.example' | fzf --reverse --multi --preview "echo {} | cut -d'-' -f2- | xargs -n1 curl -L -s | jq -C")"
        [ -n "$result" ] && echo $result | cut -d'-' -f2- | xargs -n1 curl -L -s | jq -C
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

function update() {
    echo 'zsh upgrade...'
    omz update
    zinit self-update
    zinit update --all

    echo 'brew update, upgrade, cleanup...'
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup

    echo 'tldr update...'
    tldr --update

    echo 'asdf plugin-update...'
    asdf plugin-update --all

    echo 'npm update...'
    npm update npm -g && npm update -g

    echo 'softwareupdate update...'
    softwareupdate -i -a
}

function install-completions() {
    # first create completion file, e.g.: kind completion zsh > /usr/local/share/zsh/site-functions/_kind
    autoload -U compinit && compinit
}
