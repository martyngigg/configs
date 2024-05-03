# My own theme for ZSH prompt. It is named after my 😺, Prince.
#
# The prompt provides:
#
#  top line: username, working directory, git information (if in a git repository)
#  prompt line: simply a '$' to maximise space for commands


# User (highlighted in red if running as priveleged user)
prompt_user() {
  local fg
  [[ $UID -eq 0 ]] && fg="red" || fg="yellow"

  echo -n "%{%F{$fg}%}%n%f"
}

# Current directory
prompt_dir() {
  echo -n "%F{blue}%2~%f"
}

# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  local fg
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      fg=red
    else
      fg=green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "(%{%F{$fg}%}${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}%f)"
  fi
}

prompt_status() {
  local warn_char
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    warn_char=$'\u26a0\uFE0F'         # ⚠️
  }
  local symbols
  symbols=()
  # RETCODE is set before the prompt processing begins in build_prompt so that the
  # value is not overwritten when other functions are called.
  [[ $RETCODE -ne 0 ]] && symbols+="%F{red}✘%f"
  local fg
  [[ $UID -eq 0 ]] && symbols+="$warn_char "

  [[ -n "$symbols" ]] && echo -n "$symbols"
}


build_left_top() {
  echo -n "╭╴$(prompt_status) $(prompt_user) $(prompt_dir) $(prompt_git)"
}

build_left_bottom() {
  echo -n '╰╴$ '
}

build_prompt() {
  RETCODE=$?
  build_left_top
  echo
  build_left_bottom
}

PROMPT='%f%k$(build_prompt)'
