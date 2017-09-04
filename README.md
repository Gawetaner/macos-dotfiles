# Gawetaner’s macOS dotfiles

This repository contains several dotfiles and configurations that i want to sync accross my machines. It only targets macOS.

## Requirements

- macOS 10.12 or newer
- Working internet connection during installation.

## Warnings

- Don't use this repo directly, you should first fork, review and adjust the code.
- Don't delete the repo after installing. There are several symlinks created into this repo.
- If moving the repo, rerun `symlinks.sh` or `install.sh` to update the symlinks.

## Installation

Clone this repository wherever you want, my prefered place is `~/repos/macos-dotfiles`.
```sh
git clone git@github.com:Gawetaner/-macos-dotfiles.git
```

Run the install script
```bash
cd macos-dotfiles && ./install.sh
```

## Additional steps after installation

Some steps needs to be done manually after installation.

### git
To use a separate git identity on each machine, add a `.gitconfig.local` file to your home folder that contains the local configuration. This file is imported by the repo's `.gitconfig`.

```
[user]
	name = Dennis Johannisson
	email = mail@gawetaner.de
```

## Updating

After pulling changes or modifying the files, rerun the `install.sh` script.

```bash
./install.sh
```

## TODOs

- Ask for required git configs if `.gitconfog.local` does not exist.