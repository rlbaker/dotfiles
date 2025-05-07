.PHONY: mise nvim fish ghostty homebrew

cfgdir := $(HOME)/.config

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
