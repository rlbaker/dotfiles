dotfiles = $(shell pwd)

.PHONY: fish
fish:
	@mkdir -p $$HOME/.config/fish/
	ln -s -f $(dotfiles)/fish/config.fish $$HOME/.config/fish/config.fish
	ln -s -f $(dotfiles)/fish/colors.fish $$HOME/.config/fish/colors.fish
	# ln -s -f $(dotfiles)/fish/functions $$HOME/.config/fish/functions
	fd . 'fish/functions' -x ln -s $(dotfiles)/{} "$$HOME/.config/fish/functions/{/}"
	@mkdir -p $$HOME/.config/fish/functions/
	# ln -s -f $(dotfiles)/fish/functions/fish_prompt.fish $$HOME/.config/fish/functions/fish_prompt.fish
	@touch $$HOME/.config/fish/local.fish

.PHONY: nvim
nvim:
	@mkdir -p $$HOME/.config/nvim/lua/plugins
	ln -s -f $(dotfiles)/nvim/init.lua $$HOME/.config/nvim/init.lua
	fd . 'nvim/lua/plugins' -x ln -s $(dotfiles)/{} "$$HOME/.config/nvim/lua/plugins/{/}"

.PHONY: kitty
kitty:
	@mkdir -p $$HOME/.config/kitty/
	ln -s -f $(dotfiles)/kitty/kitty.conf $$HOME/.config/kitty/kitty.conf

.PHONY: homebrew
homebrew:
	@mkdir -p $$HOME/.config/homebrew/
	ln -s -f $(dotfiles)/homebrew/Brewfile $$HOME/.config/homebrew/Brewfile
