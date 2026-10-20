# ~/.bashrc

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Load Noctalia terminal colors
# [[ -f ~/.cache/terminal-sequences ]] && cat ~/.cache/terminal-sequences

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
__gnome_accent_rgb() {
  local name
  name=$(gsettings get org.gnome.desktop.interface accent-color 2>/dev/null)
  case "${name//\'/}" in
  teal) echo "33 144 164" ;;
  green) echo "58 148 74" ;;
  yellow) echo "200 136 0" ;;
  orange) echo "237 91 0" ;;
  red) echo "230 45 66" ;;
  pink) echo "213 97 153" ;;
  purple) echo "145 65 172" ;;
  slate) echo "111 131 150" ;;
  *) echo "53 132 228" ;;
  esac
}

# __apply_accent() {
#     [[ -t 1 ]] || return
#     local r g b
#     read -r r g b <<< "$(__gnome_accent_rgb)"
#     local lr=$(( r + (255 - r) * 35 / 100 ))
#     local lg=$(( g + (255 - g) * 35 / 100 ))
#     local lb=$(( b + (255 - b) * 35 / 100 ))
#     printf '\e]4;4;rgb:%02x/%02x/%02x\a'  "$r" "$g" "$b"      # slot 4  = accent
#     printf '\e]4;12;rgb:%02x/%02x/%02x\a' "$lr" "$lg" "$lb"   # slot 12 = lighter accent
#     printf '\e]12;rgb:%02x/%02x/%02x\a'   "$r" "$g" "$b"      # cursor
# }

__apply_accent() {
  [[ -t 1 ]] || return
  local r g b
  read -r r g b <<<"$(__gnome_accent_rgb)"
  local lr=$((r + (255 - r) * 35 / 100))
  local lg=$((g + (255 - g) * 35 / 100))
  local lb=$((b + (255 - b) * 35 / 100))

  local s
  for s in 4 6; do # normal slots  -> accent
    printf '\e]4;%d;rgb:%02x/%02x/%02x\a' "$s" "$r" "$g" "$b"
  done
  for s in 12 14; do # bright slots  -> lighter accent
    printf '\e]4;%d;rgb:%02x/%02x/%02x\a' "$s" "$lr" "$lg" "$lb"
  done
  printf '\e]12;rgb:%02x/%02x/%02x\a' "$r" "$g" "$b" # cursor
}

__set_custom_prompt() {
  local EXIT_STATUS=$? # must stay the first line

  # Accent color -> user segment; a lighter shade of it -> directory segment
  local r g b
  read -r r g b <<<"$(__gnome_accent_rgb)"
  local lr=$((r + (255 - r) * 35 / 100))
  local lg=$((g + (255 - g) * 35 / 100))
  local lb=$((b + (255 - b) * 35 / 100))

  # Pick readable text for the accent segment (dark on light accents, white on dark ones)
  local lum=$(((r * 299 + g * 587 + b * 114) / 1000))
  local C_TXT_USER=$((lum > 140 ? 0 : 15))

  # Time/status segments still follow the Noctalia palette
  local C_TIME=6 C_STAT=14 C_DARK=0

  local BG_USER="\[\e[48;2;${r};${g};${b}m\]" FG_USER="\[\e[38;5;${C_TXT_USER}m\]"
  local BG_DIR="\[\e[48;2;${lr};${lg};${lb}m\]" FG_DIR="\[\e[38;5;${C_DARK}m\]"
  local BG_TIME="\[\e[48;5;${C_TIME}m\]" FG_TIME="\[\e[38;5;${C_DARK}m\]"
  local BG_STAT="\[\e[48;5;${C_STAT}m\]" FG_STAT="\[\e[38;5;${C_DARK}m\]"

  local T_USER_DIR="\[\e[38;2;${r};${g};${b}m\]\[\e[48;2;${lr};${lg};${lb}m\]"
  local T_DIR_TIME="\[\e[38;2;${lr};${lg};${lb}m\]\[\e[48;5;${C_TIME}m\]"
  local T_TIME_STATUS="\[\e[38;5;${C_TIME}m\]\[\e[48;5;${C_STAT}m\]"

  local RESET="\[\e[0m\]"
  local SEP="▶"

  local PROMPT="${BG_USER}${FG_USER}$ \u "
  PROMPT+="${T_USER_DIR}${SEP}${BG_DIR}${FG_DIR} \W "
  PROMPT+="${T_DIR_TIME}${SEP}${BG_TIME}${FG_TIME} \t "

  if [ $EXIT_STATUS -eq 0 ]; then
    PROMPT+="${T_TIME_STATUS}${SEP}${BG_STAT}${FG_STAT} ✓ "
  else
    PROMPT+="${T_TIME_STATUS}${SEP}${BG_STAT}${FG_STAT} ✗ ${EXIT_STATUS} "
  fi

  PROMPT+="${RESET} "

  local TITLE=""
  case "$TERM" in
  xterm* | rxvt*)
    TITLE="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]"
    ;;
  esac

  export PS1="${TITLE}${PROMPT}"
}

export PROMPT_COMMAND="__set_custom_prompt; __apply_accent"

# ==============================================================================

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

# Your custom aliases
alias update='doas apt update && doas apt upgrade -y && doas apt full-upgrade -y && doas apt autoremove -y'
alias ll='ls -lha --color=auto'
alias ls='ls --color=auto'

cmc() {
  "$HOME/SourceApps/gnome/command-run.sh" "$@"
}

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
~/SourceApps/starship-accent
eval "$(starship init bash)"
