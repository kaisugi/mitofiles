# Repository Guide

## Overview

This repository bootstraps an Apple Silicon Mac and keeps personal dotfiles in sync through symbolic links.

## Key Files

- `init.sh` installs Homebrew packages, developer tools, runtimes, and dotfile symlinks.
- `Brewfile` is the source of truth for Homebrew formulae and casks.
- `mas.sh` installs Mac App Store applications.
- `symlink.sh` links files from this repository into the home directory.
- `.github/workflows/test-dotfiles.yml` validates the bootstrap scripts on macOS.

## Working Agreements

- Keep setup steps safe to run more than once. Check whether a command or tool already exists before installing it.
- Keep machine-specific secrets, credentials, and generated state out of the repository.
- When adding a managed dotfile, update `symlink.sh`, the directory creation in `init.sh`, the CI symlink assertions, and `README.md` together.
- When adding a CLI installed outside Homebrew, include a clear failure message and a CI installation check.
- Preserve the Apple Silicon Homebrew prefix (`/opt/homebrew`) unless the repository's supported platforms change.
- Do not run `init.sh` as a validation command: it installs packages and changes user-level and system-level configuration.

## Validation

Run the checks relevant to the files you changed:

```bash
bash -n init.sh symlink.sh mas.sh
brew bundle check --file=Brewfile --verbose
git diff --check
```

For symlink changes, use a temporary home directory or mirror the dry-run setup in `.github/workflows/test-dotfiles.yml`; do not overwrite the active user's dotfiles during tests.
