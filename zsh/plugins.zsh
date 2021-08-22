### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

zinit wait lucid light-mode for \
    atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
        zdharma/fast-syntax-highlighting \
        OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
    atload'_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
    svn pick'completion.zsh' multisrc'git.zsh history.zsh' OMZ::lib

zinit wait lucid light-mode for \
    djui/alias-tips \
    Tarrasch/zsh-bd \
    paoloantinori/hhighlighter \
    Valodim/zsh-curl-completion

export ASDF_DIR='/usr/local/opt/asdf'
export ASDF_GROOVY_DISABLE_JAVA_HOME_EXPORT=true
zinit wait lucid light-mode for \
    pick'asdf.sh' "$ASDF_DIR" \
    pick'set-java-home.zsh' "$HOME/.asdf/plugins/java"

zinit wait svn lucid light-mode for \
    OMZ::plugins/z \
    OMZ::plugins/gradle \
    OMZ::plugins/mvn \
    blockf OMZ::plugins/docker-compose
    # OMZ::plugins/aws \
    # OMZ::plugins/kubectl \
    # OMZ::plugins/terraform

zinit wait lucid light-mode for \
    pick'.fzf.zsh' %HOME \
    pick'kube-ps1.sh' /usr/local/opt/kube-ps1/share \
    pick'br' %HOME/.config/broot/launcher/bash \
    pick'completion.zsh' %HOME/.pack

zinit lucid light-mode for \
    svn OMZ::plugins/git \
    pick'eaf.zsh' %HOME/.dotfiles/zsh

source $HOME/.dotfiles/zsh/async-prompt.zsh

# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
