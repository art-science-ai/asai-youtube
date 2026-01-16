
### Stow
- Partial stowing
	- Problem: when I stow a directory like `~/.claude` it symlinks the entire directory. I have Claude installed in multiple machines and use dotfiles to sync the configs.
	- Some configs inside ~/.claude are common to all machines and I want them in the dotfiles git repo. But some configs are machine specific and I don't want them in my dotfiles repo.