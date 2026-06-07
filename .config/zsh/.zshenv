
alias assume=". assume"
. "$HOME/.cargo/env"

# ── 1Password secret cache ────────────────────────────────────────────────────
# Reads a secret via `op` and caches the result to a mode-600 temp file with a
# TTL (default 6h). Subsequent shells within the TTL skip the `op` call.
# Usage: export FOO=$(op-cached "op://Vault/Item/field")
# Override TTL: OP_CACHE_TTL=3600 op-cached ...
op-cached() {
  local ref="$1"
  local ttl="${OP_CACHE_TTL:-21600}"
  local cache="${TMPDIR:-/tmp/}op-cache-$(printf '%s' "$ref" | shasum | cut -c1-12)"

  if [[ -f "$cache" ]] && (( $(date +%s) - $(stat -f %m "$cache") < ttl )); then
    cat "$cache"
    return
  fi

  local value
  value=$(op read --no-newline "$ref" 2>/dev/null) || return 1
  [[ -z "$value" ]] && return 1

  umask 077
  printf '%s' "$value" | tee "$cache"
}
