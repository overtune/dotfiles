# dotfiles

My dotfiles, deployed with [mise](https://mise.jdx.dev/dotfiles.html).
The repo is the source of truth: mise symlinks each file into place, so
editing `~/.zshrc` edits `zsh/zshrc` here. Commit and push as usual.

| Folder           | Deployed to                                                                        |
| ---------------- | ---------------------------------------------------------------------------------- |
| `zsh/`           | `~/.zshrc`, `~/.zshenv`                                                            |
| `tmux/`          | `~/.tmux.conf`, `~/.tmux-osx.conf`                                                 |
| `nvim-overtune/` | `~/.config/nvim-overtune` (run with `NVIM_APPNAME=nvim-overtune nvim`, alias `v`) |
| `mise/`          | `~/.config/mise/config.toml` (global tools)                                        |

The mapping lives in [`mise.toml`](mise.toml).

## New machine

```sh
# 1. Install mise: https://mise.jdx.dev/getting-started.html
# 2. Clone (uses the overtune SSH alias, see below)
git clone git@github-overtune:overtune/dotfiles.git ~/dotfiles
cd ~/dotfiles
# 3. Deploy
mise trust
mise dot apply --dry-run
mise dot apply          # refuses to overwrite existing files; move them away first
mise dot status
# 4. Install global tools
mise install
```

Not in this repo, install separately:

- [oh-my-zsh](https://ohmyz.sh/)
- [tpm](https://github.com/tmux-plugins/tpm) for tmux plugins:
  `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`, then `prefix + I` in tmux
- [fnm](https://github.com/Schniz/fnm), fzf, thefuck (used by `.zshrc`)

## GitHub access

This machine has two GitHub accounts. Plain `git@github.com` authenticates
as the wrong one, so the remote uses a host alias in `~/.ssh/config`:

```
Host github-overtune
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_overtune
```

## Adding a file

```sh
cd ~/dotfiles
mise dot add --local --source <folder>/<name> ~/.<file>
```
