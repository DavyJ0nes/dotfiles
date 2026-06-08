tap "danvergara/tools"             # dblab - database TUI client
tap "felixkratz/formulae"          # sketchybar - macOS menu bar customization
tap "nikitabobko/tap"              # Aerospace - tiling window manager
tap "pantsbuild/tap"               # Pants - monorepo build system
tap "remotemobprogramming/brew"    # mob - mob/pair programming tool
tap "thezoraiz/ascii-image-converter"

brew "aichat"                      # AI chat in the terminal (multi-provider)
brew "aider"                       # AI pair programming in the terminal
brew "gemini-cli"                  # Google Gemini CLI

brew "git"                         # Version control
brew "git-delta"                   # Syntax-highlighted diffs
brew "lazygit"                     # Git TUI
brew "jj"                          # Jujutsu - experimental VCS

brew "hcloud"                      # Hetzner Cloud CLI
brew "awslogs"                     # CloudWatch Logs viewer
brew "temporal"                    # Temporal workflow orchestration CLI

# Container engine (k8s CLIs themselves are managed by mise — see
# .config/mise/conf.d/cloud.toml)
brew "podman"                      # Container engine (Docker alternative)

# ─── Infrastructure as Code ───────────────────────────────────────────────────
# pulumi/terraform/tflint live in mise (personal.toml + cloud.toml).

# ─── Go Development ──────────────────────────────────────────────────────────
# Go toolchain and all Go developer tools (gopls, golangci-lint, gci, golines,
# delve, gofumpt, etc.) are managed by mise — see
# .config/mise/conf.d/runtimes.toml and .config/mise/conf.d/go-tools.toml.

# ─── Elixir / Erlang Development ─────────────────────────────────────────────
# Elixir and Erlang are pinned via mise (.config/mise/conf.d/runtimes.toml).
# wxwidgets stays on brew — it's a build-time C++ dep that mise's Erlang
# compile step picks up from the system.
brew "wxwidgets@3.2"               # C++ GUI library (Erlang/Elixir dependency)

# ─── Python Development ──────────────────────────────────────────────────────
# Python itself is pinned via mise; pipx, python-lsp-server, ruff stay on brew.
brew "pipx"                        # Install Python apps in isolated environments
brew "python-lsp-server"           # Python LSP server
brew "ruff"                        # Fast Python linter/formatter

# ─── Shell & Terminal ─────────────────────────────────────────────────────────
brew "bash"                        # GNU Bash (newer than macOS default)
brew "starship"                    # Cross-shell prompt
brew "tmux"                        # Terminal multiplexer
brew "tmuxinator"                  # Tmux session manager
brew "zsh-autosuggestions"         # Fish-like autosuggestions for Zsh
brew "zsh-completions"             # Additional completion definitions for Zsh
brew "zsh-syntax-highlighting"     # Fish-like syntax highlighting for Zsh

# ─── File & Search Tools ─────────────────────────────────────────────────────
brew "bat"                         # cat with syntax highlighting and Git integration
brew "eza"                         # Modern ls replacement
brew "fd"                          # Fast and user-friendly find alternative
brew "fzf"                         # Fuzzy finder for the terminal
brew "ripgrep"                     # Fast grep (rg)
brew "television"                  # Fuzzy finder TUI with many data sources
brew "tree"                        # Display directory structure as a tree
brew "walk"                        # Terminal file manager / navigator

# ─── Text Editors & IDEs ─────────────────────────────────────────────────────
brew "neovim"                      # Hyperextensible Vim-based text editor

# ─── Language Servers & Formatters ───────────────────────────────────────────
brew "marksman"                    # Markdown LSP server
brew "mdformat"                    # Markdown formatter
brew "shellcheck"                  # Shell script linter
brew "shfmt"                       # Shell script formatter
brew "superhtml"                   # HTML language server and formatter
brew "yaml-language-server"        # YAML LSP server
brew "yamllint"                    # YAML linter

# ─── Build Tools ─────────────────────────────────────────────────────────────
brew "bazel"                       # Scalable build and test tool
brew "cmake"                       # Cross-platform build system
brew "make"                        # GNU Make
brew "tree-sitter"                 # Parser generator framework
brew "tree-sitter-cli"             # Tree-sitter CLI

# ─── Compilers & Runtimes ────────────────────────────────────────────────────
brew "gcc"                          # GNU C/C++ compiler
brew "gcc@14"                       # GNU C/C++ compiler (version 14)
brew "llvm"                         # LLVM compiler infrastructure
brew "luarocks"                     # Lua package manager
brew "opam"                         # OCaml package manager
# zig and bun are pinned via mise (.config/mise/conf.d/runtimes.toml).

# ─── Data & API Tools ────────────────────────────────────────────────────────
brew "httpx"                       # HTTP toolkit / security testing
brew "jq"                          # JSON processor
brew "jqp"                         # Interactive jq playground TUI
brew "posting"                     # HTTP client TUI (API testing)
brew "xh"                          # Friendly HTTP client (HTTPie alternative)
brew "yq"                          # YAML/JSON/XML processor (jq for YAML)
brew "danvergara/tools/dblab"      # Database TUI client

# ─── Database ────────────────────────────────────────────────────────────────
brew "postgresql@14"               # PostgreSQL database (version 14)

# ─── DevOps & Security ───────────────────────────────────────────────────────
brew "act"                         # Run GitHub Actions locally
brew "gh"                          # GitHub CLI
brew "prowler"                     # Cloud security assessment tool
brew "runme"                       # Runnable Markdown notebooks / runbooks

# ─── Task & Project Management ────────────────────────────────────────────────
brew "adr-tools"                   # Architecture Decision Records CLI
brew "task"                        # Taskfile-based task runner
brew "taskopen"                    # Open files/URLs linked in Taskwarrior tasks
brew "taskwarrior-tui"             # Taskwarrior TUI

# ─── dotfiles & Environment ──────────────────────────────────────────────────
# asdf removed — mise reads .tool-versions files natively, so legacy projects
# keep working.
brew "direnv"                      # Per-directory environment variables
brew "stow"                        # Symlink manager (used for dotfiles)
brew "rtk"                         # Rust Token Killer - token-optimized CLI proxy

# ─── System Utilities ─────────────────────────────────────────────────────────
brew "blueutil"                    # Bluetooth power/discovery from the CLI
brew "carapace"                    # Multi-shell completion generator
brew "coreutils"                   # GNU core utilities (gdate, gls, etc.)
brew "diffutils"                   # GNU diff utilities
brew "gnupg"                       # GPG encryption and signing
brew "grep"                        # GNU grep
brew "gnu-sed"                     # GNU sed
brew "htop"                        # Interactive process viewer
brew "mole"                        # SSH tunnel manager
brew "nmap"                        # Network scanner
brew "p7zip"                       # 7-zip via CLI
brew "pinentry-mac"                # GPG PIN entry dialog for macOS
brew "sevenzip"                    # 7-Zip archiver
brew "socat"                       # Multipurpose relay for bidirectional data
brew "switchaudio-osx"             # Switch macOS audio input/output from CLI
brew "viddy"                       # Modern watch replacement with diffs
brew "watch"                       # Execute a program periodically
brew "wget"                        # File downloader
brew "xz"                          # XZ/LZMA compression
brew "zoxide"                      # Smarter cd with frecency ranking

# ─── Terminal Browsers & Viewers ─────────────────────────────────────────────
brew "lynx"                        # Text-based web browser
brew "poppler"                     # PDF rendering library / CLI tools
brew "viu"                         # Terminal image viewer
brew "w3m"                         # Terminal web browser

# ─── Notes & Writing ─────────────────────────────────────────────────────────
brew "zk"                          # Zettelkasten plain-text note-taking CLI

# ─── macOS Menu Bar & UI ─────────────────────────────────────────────────────
brew "felixkratz/formulae/sketchybar" # Highly customizable macOS menu bar

# ─── Mob Programming ─────────────────────────────────────────────────────────
brew "remotemobprogramming/brew/mob" # Mob/pair programming Git tool

# ─── ASCII Art ───────────────────────────────────────────────────────────────
brew "thezoraiz/ascii-image-converter/ascii-image-converter" # Convert images to ASCII art

# ─── Exercism ────────────────────────────────────────────────────────────────
brew "exercism"                    # Exercism CLI for coding practice

# ─── Casks (macOS Applications) ──────────────────────────────────────────────
cask "1password-cli"               # 1Password CLI (op)
cask "nikitabobko/tap/aerospace"   # Tiling window manager for macOS
cask "alacritty"                   # GPU-accelerated terminal emulator
cask "font-hack-nerd-font"         # Hack Nerd Font (patched with icons)
cask "font-jetbrains-mono-nerd-font" # JetBrains Mono Nerd Font
cask "font-lilex-nerd-font"        # Lilex Nerd Font
cask "font-sf-pro"                 # Apple SF Pro font
cask "gcloud-cli"                  # Google Cloud SDK / gcloud CLI
cask "ghostty"                     # Fast, feature-rich terminal emulator
cask "google-chrome"               # Google Chrome browser
cask "gpg-suite"                   # GPG tools for macOS (GPG Keychain, etc.)
cask "livebook"                    # Elixir interactive notebook
cask "obsidian"                    # Markdown-based knowledge base / notes
cask "pantsbuild/tap/pants"        # Pants monorepo build system
cask "raycast"                     # Launcher and productivity tool
cask "sf-symbols"                  # Apple SF Symbols reference app
cask "steam"                       # Gaming platform
cask "zed"                         # High-performance code editor

# Go tools are managed by mise via the `go:` backend — see
# .config/mise/conf.d/go-tools.toml.
