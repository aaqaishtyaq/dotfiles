# Scripts

Interpreted scripts in POSIX shell, Bash, Perl, Ruby, Python, etc.

## Install

I symlink mine from to `~/.local/bin/scripts` since I use `~/.local/bin` to hold lots of stuff that isn't necessarily persistent.  From within this source directory (no matter where it is) just run the following from your command line, or you can use a fancy `vi` one-liner magic wand (`!!`).

```sh
mkdir -p ~/.local/bin/ && ln -sf "$PWD" ~/.local/bin/scripts
```

Don't forget to add this to your `$PATH` by adding something like the following to your shell configuration files:

```sh
export PATH=~/.local/bin/scripts:$PATH
```
