# Makefile

# Phony targets (targets that don't represent files)
.PHONY: mise nvim fish wezterm ghostty homebrew

# Variables
cfgdir := $(HOME)/.config
# $(CURDIR) is a built-in Make variable representing the current working directory.

# Recipes

mise:
	@echo "==> Setting up mise..."
	@curl https://mise.run | sh

nvim:
	@echo "==> Setting up nvim configuration..."
	@mkdir -p "$(cfgdir)/nvim/lua/plugins"
	@-fd --type file --extension lua . nvim --exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Nvim setup complete."

fish:
	@echo "==> Setting up fish configuration..."
	@mkdir -p "$(cfgdir)/fish/functions"
	@touch "$(cfgdir)/fish/local.fish"
	@-fd --type file --extension fish . fish --exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Fish setup complete."

wezterm:
	@echo "==> Setting up wezterm configuration..."
	@mkdir -p "$(cfgdir)/wezterm"
	@-fd --type file --extension lua . wezterm --exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Wezterm setup complete."

ghostty:
	@echo "==> Setting up ghostty configuration..."
	@mkdir -p "$(cfgdir)/ghostty/themes"
	@-fd . ghostty --exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Ghostty setup complete."

homebrew:
	@echo "==> Setting up homebrew configuration..."
	@mkdir -p "$(cfgdir)/homebrew"
	@-fd . homebrew --exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}"
	@echo "Homebrew setup complete."

# Optional: An 'all' target to run common setup tasks
# .PHONY: all
# all: nvim fish wezterm ghostty homebrew
#	@echo "All configurations set up."
