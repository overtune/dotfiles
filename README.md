# dotfiles

My macOS dotfiles, managed with [mise](https://mise.jdx.dev/dotfiles.html).
The repo is the source of truth: mise symlinks each file into place, so
editing `~/.zshrc` edits `zsh/zshrc` here. Commit and push as usual.

| Folder  | Deployed to                                   |
| ------- | --------------------------------------------- |
| `zsh/`  | `~/.zshrc`, `~/.zshenv`                       |
| `tmux/` | `~/.tmux.conf`                                |
| `nvim/` | `~/.config/nvim` (Neovim 0.12+, aliases `v`, `vim`) |
| `mise/` | `~/.config/mise/config.toml` (global tools)   |

Everything is declared in [`mise.toml`](mise.toml): the `[dotfiles]` mapping,
plus the Homebrew packages and git repos that `mise bootstrap` installs.

## New machine

```sh
# 1. Homebrew and mise (https://brew.sh)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
brew install mise

# 2. Clone over HTTPS (the repo is public; switch to SSH later, see below)
git clone https://github.com/overtune/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Install packages, clone oh-my-zsh and tmux-themepack, deploy the
#    dotfiles and install global tools. mise refuses to overwrite existing
#    files, so move any default ~/.zshrc etc. out of the way first.
mise trust
mise bootstrap --dry-run
mise bootstrap

# 4. Start a new shell
exec zsh
```

`mise bootstrap` is safe to re-run: anything already in place is left alone.
`mise bootstrap plan` shows what it would change.

### Manual steps

Things `mise bootstrap` does not cover:

- **Node for projects:** mise installs the global Node version and switches
  to a project's `.nvmrc` / `.node-version` on `cd`, but does not download
  versions on `cd`. Run `mise install` in a project the first time.
- **nvim:** nothing to do. On the first start lazy.nvim installs the plugins
  and Mason the language servers and formatters (Node must be available).
- **Casks from third-party taps:** `brew install --cask simpel/tap/ruler`.
- **SSH and git config:** `~/.ssh/config`, the SSH keys and `~/.gitconfig`
  are not in this repo. Set them up as described under
  [GitHub access](#github-access).

## Day to day

```sh
mise dot status                 # are all dotfiles linked?
mise bootstrap --dry-run        # anything missing on this machine?
mise bootstrap --update         # also fast-forward oh-my-zsh and themepack
```

To add a dotfile, move it into the repo and let mise link it back:

```sh
cd ~/dotfiles
mise dot add --local --source <folder>/<name> ~/.<file>
```

To add a Homebrew package, add a line under `[bootstrap.packages]` in
`mise.toml`, e.g. `"brew:jq" = "latest"` or `"brew-cask:slack" = "latest"`,
then run `mise bootstrap`.

## GitHub access

This machine has two GitHub accounts. Plain `git@github.com` authenticates
as the wrong one, so pushing uses a host alias in `~/.ssh/config`:

```
Host github-overtune
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_overtune
```

With that in place, switch the clone to SSH:

```sh
git -C ~/dotfiles remote set-url origin git@github-overtune:overtune/dotfiles.git
```
