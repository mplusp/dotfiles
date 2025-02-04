# dotfiles

These are my dotfiles. Feel free to use or copy what you need from this repo.

## Setup Instructions

I manage these dotfiles with `stow`, which is a symlink manager. Clone this
repository to the root of your home directory, `~/.dotfiles` for example.

> [!Note]
> There may be submodules contained inside this repo (see
> [.gitmodules](.gitmodules) for a list of them). Use the `--recures-submodules`
> option while cloning to check out the submodules.

[Contribution guidelines for this project](docs/CONTRIBUTING.md)
Each sub-directory can be individually linked to its correct location using
`stow directory_name` inside the root of this repository. To set up the
dotfiles for `git` just run `stow git`, for example.

To remove the links that were created by `stow`, run `stow -D directory_name`.

You can of course create the symlinks yourself with `ln` or just copy files to
the correct location, if you don't want to use `stow`.
