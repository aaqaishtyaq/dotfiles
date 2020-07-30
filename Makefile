.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "symlinking zsh config files"
	@mkdir -p $(HOME)/.config/zsh
	@ln -fs "$(CURDIR)/zsh/.zshrc" $(HOME)/.zshrc
	@for file in $(shell find $(CURDIR)/zsh -type f -name ".zsh.*"); do \
		f=$$(basename $$file); \
		ln -fs $$file $(HOME)/.config/zsh/$$f; \
	done; \

	@echo "symlinking alacritty config files"
	@ALACRITTY_PATH="$(HOME)/.config/alacritty"
	@mkdir -p $(ALACRITTY_PATH)
	@ln -fs "$(CURDIR)/alacritty/alacritty.yml" $(ALACRITTY_PATH)

	@echo "symlinking alacritty config files"
	@ALACRITTY_PATH="$(HOME)/.config/alacritty"
	@mkdir -p $(ALACRITTY_PATH)
	@ln -fs "$(CURDIR)/alacritty/alacritty.yml" $(ALACRITTY_PATH)

.PHONY: help
## help: print this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'
