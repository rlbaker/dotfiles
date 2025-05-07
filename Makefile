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
	@-find nvim -type f -name "*.lua" -exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}" \;
	@echo "Nvim setup complete."

fish:
	@echo "==> Setting up fish configuration..."
	@mkdir -p "$(cfgdir)/fish/functions"
	@touch "$(cfgdir)/fish/local.fish"
	@-find fish -type f -name "*.fish" -exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}" \;
	@echo "Fish setup complete."

wezterm:
	@echo "==> Setting up wezterm configuration..."
	@mkdir -p "$(cfgdir)/wezterm"
	@-find wezterm -type f -name "*.lua" -exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}" \;
	@echo "Wezterm setup complete."

ghostty:
	@echo "==> Setting up ghostty configuration..."
	@mkdir -p "$(cfgdir)/ghostty/themes"
	@-find ghostty -type f -exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}" \;
	@echo "Ghostty setup complete."

homebrew:
	@echo "==> Setting up homebrew configuration..."
	@mkdir -p "$(cfgdir)/homebrew"
	@-find homebrew -type f -exec ln -vs "$(CURDIR)/{}" "$(cfgdir)/{}" \;
	@echo "Homebrew setup complete."

# Optional: An 'all' target to run common setup tasks
# .PHONY: all
# all: nvim fish wezterm ghostty homebrew
#	@echo "All configurations set up."
