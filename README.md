# dotfiles

Personal zsh config — `zshrc` and `zshenv`. Live as symlinks at `~/.zshrc` and `~/.zshenv`.

## Layout

| File | Symlink target | Purpose |
|---|---|---|
| `zshrc` | `~/.zshrc` | Interactive shell config — oh-my-zsh + powerlevel10k, plugins, aliases, project-cd helpers (`pj`, `cct`). |
| `zshenv` | `~/.zshenv` | Always-sourced env (incl. non-interactive subshells) — exports `LINEAR_API_KEY` from macOS Keychain. |

## Bootstrap on a new machine

```sh
git clone https://github.com/Binderys/dotfiles ~/dotfiles
ln -sfn ~/dotfiles/zshrc  ~/.zshrc
ln -sfn ~/dotfiles/zshenv ~/.zshenv
exec zsh
```

## Dependencies

- **zsh** — default on macOS
- **oh-my-zsh** at `~/.oh-my-zsh` — <https://ohmyz.sh>
- **powerlevel10k** theme — <https://github.com/romkatv/powerlevel10k> (configure once per machine via `p10k configure`; writes `~/.p10k.zsh`, currently un-versioned)
- **pyenv** at `$PYENV_ROOT=$HOME/.pyenv` — <https://github.com/pyenv/pyenv>
- **bun** at `$HOME/.bun/bin` — <https://bun.sh>
- **quarto** at `/Applications/quarto/bin` — <https://quarto.org>

## LINEAR_API_KEY (Keychain entry)

`zshenv` resolves `LINEAR_API_KEY` from macOS Keychain so it inherits to every shell — interactive and non-interactive — without sitting in plaintext on disk. To populate on a fresh machine:

```sh
read -rs 'Linear API key: ' linkey && \
  security add-generic-password -a "$USER" -s LINEAR_API_KEY -U -w "$linkey" && \
  unset linkey
```

`read -rs` keeps the value out of shell history. After adding, `exec zsh` and verify:

```sh
[[ -n $LINEAR_API_KEY ]] && echo "set, length=${#LINEAR_API_KEY}"
```

First read by `security` triggers a Keychain auth prompt — choose **Always Allow** so future shell starts don't prompt.
