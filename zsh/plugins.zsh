### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
		print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
		print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
	zdharma-continuum/zinit-annex-rust \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-bin-gem-node
### End of Zinit's installer chunk

zinit wait lucid light-mode for \
	atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
	Aloxaf/fzf-tab \
	zdharma-continuum/fast-syntax-highlighting \
	OMZP::colored-man-pages \
	blockf zsh-users/zsh-completions \
	atload'!_zsh_autosuggest_start' zsh-users/zsh-autosuggestions

zinit snippet OMZL::completion.zsh
zinit snippet OMZL::git.zsh
export HIST_STAMPS='yyyy-mm-dd'
zinit snippet OMZL::history.zsh

zinit wait lucid light-mode for \
	djui/alias-tips \
	Tarrasch/zsh-bd \
	paoloantinori/hhighlighter \
	Valodim/zsh-curl-completion \
	rupa/z

export ASDF_GROOVY_DISABLE_JAVA_HOME_EXPORT=true
export ASDF_JAVA_CACHE_DIR="${TMPDIR:-/tmp}/asdf-java.cache/"
zinit wait lucid light-mode for \
	pick'asdf.sh' '/usr/local/opt/asdf/libexec/' \
	pick'set-java-home.zsh' "$HOME/.asdf/plugins/java"
# prune cache:
# export ASDF_JAVA_CACHE_DIR="${TMPDIR:-/tmp}/asdf-java-$(whoami).cache/"
# ls -al "$ASDF_JAVA_CACHE_DIR"
# rm -rf "$ASDF_JAVA_CACHE_DIR"
# check settings:
# cat "$HOME/.asdfrc"

zinit wait lucid light-mode for \
	OMZP::mvn \
	blockf OMZP::docker-compose
	# OMZP::aws \
	# OMZP::kubectl \
	# OMZP::terraform

zinit wait lucid light-mode for \
	pick'.fzf.zsh' %HOME \
	pick'kube-ps1.sh' /usr/local/opt/kube-ps1/share \
	pick'br' %HOME/.config/broot/launcher/bash \
	pick'completion.zsh' %HOME/.pack

zinit lucid light-mode for \
	OMZP::direnv \
	OMZP::git \
	wfxr/forgit \
	pick'eaf.zsh' %HOME/.dotfiles/zsh

source $HOME/.dotfiles/zsh/async-prompt.zsh

# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
