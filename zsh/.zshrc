source [path to antigen]

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M viins "^[OA" history-substring-search-up
bindkey -M viins "^[OB" history-substring-search-down

# Bundles from the default repo (robbyrussell's oh-my-zsh).
#
antigen bundle git
antigen bundle pip
# antigen bundle command-not-found
antigen bundle virtualenv
# antigen bundle lukechilds/zsh-nvm
antigen bundle brew
# antigen bundle brew-cask
antigen bundle npm
antigen bundle bower
antigen bundle rupa/z
antigen bundle rimraf/k
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle djui/alias-tips
antigen bundle horosgrisa/autoenv
antigen bundle voronkovich/mysql.plugin.zsh
antigen bundle horosgrisa/mysql-colorize
#antigen bundle robbyrussell/oh-my-zsh
antigen bundle jocelynmallon/zshmarks
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme refined

antigen bundle vi-mode
# Tell antigen that you're done.
antigen apply



source ~/.zsh_aliases

#PATH
export PATH="[path to pyenv]:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init -)"

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

export CLOUDSDK_PYTHON="python2.7"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '[path to google cloud]' ]; then . '[path to google cloud]'; fi

# The next line enables shell command completion for gcloud.
if [ -f '[path to google cloud completion]' ]; then . '[path to google cloud completions]'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# npm
export PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
