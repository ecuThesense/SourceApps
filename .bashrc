# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load Noctalia terminal colors
[[ -f ~/.cache/terminal-sequences ]] && cat ~/.cache/terminal-sequences

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# set variable identifying the chroot you work in
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ==================
# CUSTOM BASH PROMPT
# ==================
__set_custom_prompt() {
    local EXIT_STATUS=$?

    # Palette slots 0-15: these follow the Noctalia theme
    local C_USER=4 C_DIR=12 C_TIME=6 C_STAT=14   # segment backgrounds
    local C_LIGHT=15 C_DARK=0                    # text colors

    local BG_USER="\[\e[48;5;${C_USER}m\]"  FG_USER="\[\e[38;5;${C_DARK}m\]"
    local BG_DIR="\[\e[48;5;${C_DIR}m\]"    FG_DIR="\[\e[38;5;${C_DARK}m\]"
    local BG_TIME="\[\e[48;5;${C_TIME}m\]"  FG_TIME="\[\e[38;5;${C_DARK}m\]"
    local BG_STAT="\[\e[48;5;${C_STAT}m\]"  FG_STAT="\[\e[38;5;${C_DARK}m\]"

    local T_USER_DIR="\[\e[38;5;${C_USER}m\]\[\e[48;5;${C_DIR}m\]"
    local T_DIR_TIME="\[\e[38;5;${C_DIR}m\]\[\e[48;5;${C_TIME}m\]"
    local T_TIME_STATUS="\[\e[38;5;${C_TIME}m\]\[\e[48;5;${C_STAT}m\]"

    local RESET="\[\e[0m\]"
    local SEP="▶"

    # 1. Username
    local PROMPT="${BG_USER}${FG_USER}$ \u "

    # 2. Directory
    PROMPT+="${T_USER_DIR}${SEP}${BG_DIR}${FG_DIR} \W "

    # 3. Time
    PROMPT+="${T_DIR_TIME}${SEP}${BG_TIME}${FG_TIME} \t "

    # 4. Status
    if [ $EXIT_STATUS -eq 0 ]; then
        PROMPT+="${T_TIME_STATUS}${SEP}${BG_STAT}${FG_STAT} ✓ "
    else
        PROMPT+="${T_TIME_STATUS}${SEP}${BG_STAT}${FG_STAT} ✗ ${EXIT_STATUS} "
    fi

    # 5. End prompt with a reset and a space for typing
    PROMPT+="${RESET} "

    # Set terminal window title (Preserved from your original config)
    local TITLE=""
    case "$TERM" in
        xterm*|rxvt*)
            TITLE="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"
            ;;
    esac

    # Export the final built prompt string
    export PS1="${TITLE}${PROMPT}"
}

# Execute the function to dynamically generate the prompt every time you press Enter
export PROMPT_COMMAND=__set_custom_prompt
# ==============================================================================


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Your custom aliases
alias update='apt update && apt upgrade -y && apt full-upgrade -y && apt autoremove -y'
alias ll='ls -lha --color=auto'
alias ls='ls --color=auto'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Byobu prompt integration
[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt

# Your custom Auto-run ls when changing directories
cd() {
    builtin cd "$@" && ls -a --color=auto
}
export EDITOR=nvim
export VISUAL=nvim
export NNN_OPENER=nvim
. "$HOME/.cargo/env"
