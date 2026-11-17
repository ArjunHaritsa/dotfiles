# Setup Instructions

# System Requirements
Make sure you have the following dependencies installed:
- git
- curl
- [Optional] If you are using `Wezterm` - background pictures for shuffling at: `~/Pictures/Wallpapers`
- Os specific installations
  - Linux   : apt
  - MacOS  : brew (macports on intel based systems)
  - Windows 󰖳 : winget

# Install [`mise`](https://mise.jdx.dev)

`mise` is a all in one version and tools management software that can also manage bootstrapping and dotfiles.
The dotfiles on this repo are synced and configured by `mise` across various devices.

- Install `mise` via curl
```sh
curl -fsSL https://mise.run | sh
```

- export `mise` in the `PATH` variable
```sh
# For linux and macos. Windows clones should extend the path in environment section
export PATH="$HOME/.local/bin:$PATH"
```
# Bootstrap from `mise`

The below command clones the repository to `~/dotfiles` and trusts `mise` configurations under `~/.dotfiles/.config/mise`

```sh
mise bootstrap --from 'https://github.com/ArjunHaritsa/dotfiles.git?ref=mise-config' --from-dir ~/.dotfiles --config-dir .config/mise
```

> [!NOTE]
> Run `mise bootstrap-macports` on older macs with Macports
