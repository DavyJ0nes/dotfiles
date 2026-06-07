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

# ── Tmux task session ─────────────────────────────────────────────────────────
# Spawn (or attach) a tmux session named <name> with an omp pane on the left
# and two helper panes stacked on the right. Usage: tasksesh <name> [start-dir]
function tasksesh() {
  local name="${1:?Usage: tasksesh <session-name> [start-dir]}"
  local dir="${2:-$PWD}"

  if tmux has-session -t "$name" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      tmux switch-client -t "$name"
    else
      tmux attach -t "$name"
    fi
    return
  fi

  tmux new-session -d -s "$name" -c "$dir" -n work
  tmux split-window -h -t "$name:work" -c "$dir"
  tmux split-window -v -t "$name:work.2" -c "$dir"
  tmux select-pane -t "$name:work.1"
  tmux send-keys -t "$name:work.1" "omp" C-m

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$name"
  else
    tmux attach -t "$name"
  fi
}

# ── Jira → branch ─────────────────────────────────────────────────────────────
# Pick a branch type, then pick (or type custom) a Jira ticket. Slugs the
# summary and creates the branch as <type>/<TICKET>-<slug>.
function jbranch() {
  local type ticket summary slug branch
  local types=(chore feat fix refactor docs test perf)

  type=$(gum choose --header "Branch type" "${types[@]}") || return 1
  [[ -z "$type" ]] && return 1

  local list result query selection
  list=$(jira issue list -a "$(jira me)" -q "status != Done" --plain --columns KEY,SUMMARY 2>/dev/null | tail -n +2)
  result=$(printf '%s\n' "$list" | fzf --print-query --prompt "ticket> " --header "Pick a ticket or type custom (e.g. no-tkt)")
  query=$(printf '%s\n' "$result"   | sed -n '1p')
  selection=$(printf '%s\n' "$result" | sed -n '2p')

  if [[ -n "$selection" ]]; then
    ticket=$(awk -F'\t' '{print $1}' <<< "$selection")
    summary=$(awk -F'\t' '{print $2}' <<< "$selection")
  else
    [[ -z "$query" ]] && return 1
    ticket="$query"
    summary=$(gum input --placeholder "Description" --prompt "desc> ")
    [[ -z "$summary" ]] && return 1
  fi

  slug=$(echo "$summary" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' | cut -c1-50)
  branch="$type/$ticket-$slug"

  if gum confirm "Create branch '$branch'?"; then
    git checkout -b "$branch"
  fi
}

# ── AI commit message ─────────────────────────────────────────────────────────
# Generate a conventional commit message for STAGED changes via Claude.
# Pulls the ticket ID from the current branch (e.g. chore/PNO-4122-...).
function ai-commit() {
  if git diff --cached --quiet; then
    echo "ai-commit: nothing staged. Run 'git add' first." >&2
    return 1
  fi

  local branch ticket diff prompt msg tmp
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  ticket=$(echo "$branch" | grep -oE '[A-Z]+-[0-9]+' | head -1)
  diff=$(git diff --cached)

  prompt="Generate a conventional commit message for the following git diff.

Required format:
<type>(<scope>): <short description>

<short explanation>

Rules:
- <type>: feat, fix, chore, refactor, docs, test, perf, style, build, ci
- <scope>: ${ticket:-derive a meaningful scope from the changes}
- Subject in imperative mood, no trailing period, under 72 chars
- Body explains *why*, not *what* — wrap at 80 cols, max 4 lines
- Output ONLY the message: no markdown fences, no preamble

Writing style — assume an auditor will read this:
- Be precise and factual; no hyperbole or marketing language
- State the change neutrally; avoid 'cleanup', 'improvements', 'tweaks' — say
  exactly what changed and why
- Surface anything an auditor would want flagged: security-relevant changes,
  permission/IAM/RBAC adjustments, dependency upgrades with CVE relevance,
  data-handling or PII changes, changes to encryption or auth flows
- Reference the driver of the change (ticket, incident, policy, CVE) when
  identifiable from the diff or branch context
- Do not fabricate motivation: if the *why* isn't determinable from the diff,
  describe the change at a higher level and stop there

--- DIFF ---
$diff"

  msg=$(claude -p "$prompt" 2>/dev/null)
  if [[ -z "$msg" ]]; then
    echo "ai-commit: claude returned no output." >&2
    return 1
  fi

  echo "─── proposed commit message ───"
  echo "$msg"
  echo "───────────────────────────────"
  echo

  case $(gum choose "Commit as-is" "Edit then commit" "Cancel") in
    "Commit as-is")
      printf '%s\n' "$msg" | git commit -F -
      ;;
    "Edit then commit")
      tmp=$(mktemp -t ai-commit.XXXXXX)
      printf '%s\n' "$msg" > "$tmp"
      ${EDITOR:-vi} "$tmp"
      git commit -F "$tmp"
      rm -f "$tmp"
      ;;
  esac
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
  echo 'updating mise'
  mise self-update --yes
  mise plugins update
  mise upgrade

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
