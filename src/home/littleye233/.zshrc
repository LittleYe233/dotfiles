# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo z extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#export http_proxy="http://localhost:7890"
#export https_proxy="http://localhost:7890"

alias ls="eza"
alias psa="ps -auxw"
alias grep="rg"
alias rm='echo "Use trash-put instead"; false'
alias trash='trashy put'

# fzf
source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_COMMAND='fd --hidden --follow -E ".git" -E "node_modules" . /etc /home'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=alt-j:down,alt-k:up,alt-i:toggle+down --border --preview-window=down --history-size=1000000'
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# use fzf in bash and zsh
# Use ~~ as the trigger sequence instead of the default **
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
#export FZF_COMPLETION_OPTS=''

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

# Misc
export EDITOR="vim"
export PAGER="less"
export GPG_TTY=`tty`
export PATH="`pwd`/.local/bin:$PATH"

# trashy
#compdef trashy

autoload -U is-at-least

_trashy() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-c+[When to use colors]:COLOR_STATUS:(auto always never)' \
'--color=[When to use colors]:COLOR_STATUS:(auto always never)' \
'--time=[When to use time]:TIME_DISPLAY_MODE:(precise imprecise)' \
'-t+[When to format as a table]:TABLE_STATUS:(auto always never)' \
'--table=[When to format as a table]:TABLE_STATUS:(auto always never)' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_trashy_commands" \
"*::: :->trashy" \
&& ret=0
    case $state in
    (trashy)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:trashy-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'*--before=[Filter by time (older than)]:BEFORE: ' \
'*--older-than=[Filter by time (older than)]:BEFORE: ' \
'*--older=[Filter by time (older than)]:BEFORE: ' \
'*--within=[Filter by time]:WITHIN: ' \
'*--newer-than=[Filter by time]:WITHIN: ' \
'*--newer=[Filter by time]:WITHIN: ' \
'*--regex=[Filter by regex]:REGEX: ' \
'*--glob=[Filter by glob]:GLOB: ' \
'*--substring=[Filter by substring]:SUBSTRING: ' \
'*--exact=[Filter by exact match]:EXACT: ' \
'-m+[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'--match=[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'*-d+[Filter by directory]:DIRECTORIES:_files' \
'*--directory=[Filter by directory]:DIRECTORIES:_files' \
'*--dir=[Filter by directory]:DIRECTORIES:_files' \
'-n+[Show '\''n'\'' maximum trash items]:MAX: ' \
'--max=[Show '\''n'\'' maximum trash items]:MAX: ' \
'--rev[Reverse the sorting of trash items]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::patterns -- Filter by pattern:' \
&& ret=0
;;
(put)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
'*::paths -- The paths to put into the trash:_files' \
&& ret=0
;;
(empty)
_arguments "${_arguments_options[@]}" \
'*--before=[Filter by time (older than)]:BEFORE: ' \
'*--older-than=[Filter by time (older than)]:BEFORE: ' \
'*--older=[Filter by time (older than)]:BEFORE: ' \
'*--within=[Filter by time]:WITHIN: ' \
'*--newer-than=[Filter by time]:WITHIN: ' \
'*--newer=[Filter by time]:WITHIN: ' \
'*--regex=[Filter by regex]:REGEX: ' \
'*--glob=[Filter by glob]:GLOB: ' \
'*--substring=[Filter by substring]:SUBSTRING: ' \
'*--exact=[Filter by exact match]:EXACT: ' \
'-m+[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'--match=[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'*-d+[Filter by directory]:DIRECTORIES:_files' \
'*--directory=[Filter by directory]:DIRECTORIES:_files' \
'*--dir=[Filter by directory]:DIRECTORIES:_files' \
'-n+[Show '\''n'\'' maximum trash items]:MAX: ' \
'--max=[Show '\''n'\'' maximum trash items]:MAX: ' \
'(--before --within --glob --regex --exact --substring -m --match --rev -n --max -d --directory)*-r+[Filter by ranges]:RANGES: ' \
'(--before --within --glob --regex --exact --substring -m --match --rev -n --max -d --directory)*--ranges=[Filter by ranges]:RANGES: ' \
'--rev[Reverse the sorting of trash items]' \
'(--before --within --glob --regex --exact --substring -m --match --rev -n --max -d --directory)--all[Empty all files]' \
'-f[Skip confirmation]' \
'--force[Skip confirmation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::patterns -- Filter by pattern:' \
&& ret=0
;;
(restore)
_arguments "${_arguments_options[@]}" \
'*--before=[Filter by time (older than)]:BEFORE: ' \
'*--older-than=[Filter by time (older than)]:BEFORE: ' \
'*--older=[Filter by time (older than)]:BEFORE: ' \
'*--within=[Filter by time]:WITHIN: ' \
'*--newer-than=[Filter by time]:WITHIN: ' \
'*--newer=[Filter by time]:WITHIN: ' \
'*--regex=[Filter by regex]:REGEX: ' \
'*--glob=[Filter by glob]:GLOB: ' \
'*--substring=[Filter by substring]:SUBSTRING: ' \
'*--exact=[Filter by exact match]:EXACT: ' \
'-m+[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'--match=[What type of pattern to use]:MATCH:(regex substring glob exact)' \
'*-d+[Filter by directory]:DIRECTORIES:_files' \
'*--directory=[Filter by directory]:DIRECTORIES:_files' \
'*--dir=[Filter by directory]:DIRECTORIES:_files' \
'-n+[Show '\''n'\'' maximum trash items]:MAX: ' \
'--max=[Show '\''n'\'' maximum trash items]:MAX: ' \
'(--before --within --glob --regex --exact --substring -m --match --rev -n --max -d --directory)*-r+[Filter by ranges]:RANGES: ' \
'(--before --within --glob --regex --exact --substring -m --match --rev -n --max -d --directory)*--ranges=[Filter by ranges]:RANGES: ' \
'--rev[Reverse the sorting of trash items]' \
'-f[Skip confirmation]' \
'--force[Skip confirmation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::patterns -- Filter by pattern:' \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
':shell -- shell to generate completions for:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(manpage)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_trashy__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:trashy-help-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(put)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(empty)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(restore)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(manpage)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_trashy_commands] )) ||
_trashy_commands() {
    local commands; commands=(
'list:List files' \
'put:Put files' \
'empty:PERMANENTLY removes files' \
'restore:Restore files' \
'completions:Generates completion for a shell' \
'manpage:Generates manpages' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'trashy commands' commands "$@"
}
(( $+functions[_trashy__completions_commands] )) ||
_trashy__completions_commands() {
    local commands; commands=()
    _describe -t commands 'trashy completions commands' commands "$@"
}
(( $+functions[_trashy__help__completions_commands] )) ||
_trashy__help__completions_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help completions commands' commands "$@"
}
(( $+functions[_trashy__empty_commands] )) ||
_trashy__empty_commands() {
    local commands; commands=()
    _describe -t commands 'trashy empty commands' commands "$@"
}
(( $+functions[_trashy__help__empty_commands] )) ||
_trashy__help__empty_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help empty commands' commands "$@"
}
(( $+functions[_trashy__help_commands] )) ||
_trashy__help_commands() {
    local commands; commands=(
'list:List files' \
'put:Put files' \
'empty:PERMANENTLY removes files' \
'restore:Restore files' \
'completions:Generates completion for a shell' \
'manpage:Generates manpages' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'trashy help commands' commands "$@"
}
(( $+functions[_trashy__help__help_commands] )) ||
_trashy__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help help commands' commands "$@"
}
(( $+functions[_trashy__help__list_commands] )) ||
_trashy__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help list commands' commands "$@"
}
(( $+functions[_trashy__list_commands] )) ||
_trashy__list_commands() {
    local commands; commands=()
    _describe -t commands 'trashy list commands' commands "$@"
}
(( $+functions[_trashy__help__manpage_commands] )) ||
_trashy__help__manpage_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help manpage commands' commands "$@"
}
(( $+functions[_trashy__manpage_commands] )) ||
_trashy__manpage_commands() {
    local commands; commands=()
    _describe -t commands 'trashy manpage commands' commands "$@"
}
(( $+functions[_trashy__help__put_commands] )) ||
_trashy__help__put_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help put commands' commands "$@"
}
(( $+functions[_trashy__put_commands] )) ||
_trashy__put_commands() {
    local commands; commands=()
    _describe -t commands 'trashy put commands' commands "$@"
}
(( $+functions[_trashy__help__restore_commands] )) ||
_trashy__help__restore_commands() {
    local commands; commands=()
    _describe -t commands 'trashy help restore commands' commands "$@"
}
(( $+functions[_trashy__restore_commands] )) ||
_trashy__restore_commands() {
    local commands; commands=()
    _describe -t commands 'trashy restore commands' commands "$@"
}

if [ "$funcstack[1]" = "_trashy" ]; then
    _trashy "$@"
else
    compdef _trashy trashy
fi
