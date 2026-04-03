# ── Search helpers ────────────────────────────────────────────────────────────
function __ddg() {
  local query="${*}"
  if [[ -z "$query" ]]; then
    echo "Usage: ? <query>"
    return 1
  fi
  local encoded="${query// /+}"
  w3m "https://duckduckgo.com/?q=${encoded}"
}

function __claude_search() {
  local prompt="${*}"
  if [[ -z "$prompt" ]]; then
    echo "Usage: ?? <prompt>"
    return 1
  fi
  command claude "$prompt"
}

# ── Eza: git-aware ll ─────────────────────────────────────────────────────────
function ll() {
  local eza_opts=(--group --header --group-directories-first --long)
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    eza "${eza_opts[@]}" --git "$@"
  else
    eza "${eza_opts[@]}" "$@"
  fi
}

# ── Git helpers ───────────────────────────────────────────────────────────────
function gwip() {
  git add -A
  git rm "$(git ls-files --deleted)" 2>/dev/null
  git commit -m "--wip--" --no-verify
}

function gunwip() {
  git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1
}

function gbage() {
  git for-each-ref --sort=committerdate refs/heads/ \
    --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"
}

function gbda() {
  local default_branch
  default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  default_branch=${default_branch:-main}

  # Delete branches gone from remote
  if [[ "$1" == "-g" || "$1" == "--gone" ]]; then
    git for-each-ref refs/heads/ --format="%(refname:short) %(upstream:track)" | \
      awk '$2 == "[gone]" { print $1 }' | \
      xargs -r git branch -D
  fi

  # Delete merged branches
  git branch --merged | \
    grep -vE '^\*|^\+|^\s*(master|main|develop)\s*$' | \
    xargs -r git branch -d
}

function gpob() {
  git push origin "$(git rev-parse --abbrev-ref HEAD)"
}

# ── Port inspector ────────────────────────────────────────────────────────────
function whoseport() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: whoseport PORT"
    return 1
  fi
  local port=$1
  if command -v lsof &>/dev/null; then
    echo "== TCP =="
    sudo lsof -nP -iTCP:$port -sTCP:LISTEN 2>/dev/null
    echo "== UDP =="
    sudo lsof -nP -iUDP:$port 2>/dev/null
  elif command -v ss &>/dev/null; then
    echo "== TCP/UDP =="
    ss -lntup "( sport = :$port )"
  else
    echo "No suitable tool found (need lsof or ss)."
    return 1
  fi
}

# ── Kubernetes helpers ────────────────────────────────────────────────────────
function kbgetall() {
  local NS
  if [[ -n "$1" ]]; then
    NS="-n $1"
  else
    NS="--all-namespaces"
  fi
  echo "PODS" && echo "----"
  kubectl get pods $NS
  echo "\nSERVICES" && echo "--------"
  kubectl get svc $NS
  echo "\nDEPLOYMENTS" && echo "---------"
  kubectl get deployments $NS
  echo "\nINGRESS" && echo "-------"
  kubectl get ingress $NS
  echo "\nJOBS" && echo "-------"
  kubectl get jobs $NS
}

# ── Docker helpers ────────────────────────────────────────────────────────────
function dclean() {
  docker container prune -f
  docker image prune -f
  docker volume prune -f
}

# ── System helpers ────────────────────────────────────────────────────────────
function calc() {
  local result
  result="$(printf "scale=10;%s\n" "$*" | bc --mathlib | tr -d '\\\n')"
  if [[ "$result" == *.* ]]; then
    printf "%s" "$result" | sed -e 's/^\./0./' -e 's/^-\./-0./' -e 's/0*$//;s/\.$//'
  else
    printf "%s" "$result"
  fi
  printf "\n"
}

function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

function gi() {
  curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$*"
}

# Colourised man pages
function man() {
  env \
    LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
    LESS_TERMCAP_md="$(printf '\e[1;31m')" \
    LESS_TERMCAP_me="$(printf '\e[0m')" \
    LESS_TERMCAP_se="$(printf '\e[0m')" \
    LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
    LESS_TERMCAP_ue="$(printf '\e[0m')" \
    LESS_TERMCAP_us="$(printf '\e[1;32m')" \
    man "$@"
}

# ── Claude with tmux notifications ───────────────────────────────────────────
function ai-chat-claude() {
  printf '\033]2;AI: Claude\033\\'
  if [[ -n "$TMUX" ]]; then
    tmux set-window-option -t "$TMUX_PANE" monitor-silence 3
    tmux set-window-option -t "$TMUX_PANE" monitor-activity on
  fi
  claude
  if [[ -n "$TMUX" ]]; then
    tmux set-window-option -t "$TMUX_PANE" monitor-silence 0
  fi
  printf '\033]2;AI: Closed\033\\'
}

# ── Update everything ─────────────────────────────────────────────────────────
function update() {
  echo 'start updating ...'

  echo "========================"
  local TO_UPDATE
  TO_UPDATE=$(brew outdated -v)

  echo 'updating homebrew'
  brew update
  brew upgrade --greedy
  brew cleanup --prune=all

  echo "========================"
  echo 'updating GH extensions'
  gh extension upgrade --all

  echo "========================"
  echo 'checking Apple Updates'
  /usr/sbin/softwareupdate -ia

  echo "========================"
  echo 'updating rust'
  rustup update

  echo "========================"
  echo "updated brew packages:"
  echo "$TO_UPDATE"
}

# ── Taskwarrior ───────────────────────────────────────────────────────────────
function ttprio() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: ttprio <id> <order>" >&2
    return 1
  fi
  local id=$1 ord=$2
  if ! [[ $id =~ ^[0-9]+$ ]]; then
    echo "ttprio: <id> must be a number (got '$id')" >&2
    return 1
  fi
  if ! [[ $ord =~ ^-?[0-9]+$ ]]; then
    echo "ttprio: <order> must be an integer (got '$ord')" >&2
    return 1
  fi
  command task $id modify todayorder:$ord
}
