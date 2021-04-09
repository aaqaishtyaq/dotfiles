CONFIG_PATH = $(HOME)/.config

.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "Please Use individual modules";

	@echo "symlinking alacritty config files"
	@ALACRITTY_PATH="$(HOME)/.config/alacritty"
	@mkdir -p $(ALACRITTY_PATH)
	@ln -fs "$(CURDIR)/alacritty/alacritty.yml" $(ALACRITTY_PATH)

	@echo "symlinking dircolors"
	@mkdir -p "$(CONFIG_PATH)/dircolors"
	@echo "$(CURDIR)"
	@ln -sf "$(CURDIR)/dircolors/dircolors" "$(CONFIG_PATH)/dircolors/.dircolors"

.PHONY: help
## help: print this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: zsh
zsh:
	@mkdir -p ${HOME}/.config/zsh.d/;
	@ln -fs "$(CURDIR)/config/zsh.d/.zshrc" "${HOME}/.zshrc";
	@for file in $(shell find $(CURDIR)/config/zsh.d -type f -name "*.zsh"); do \
		f=$$(basename $$file); \
		ln -fs $$file "${CONFIG_PATH}/zsh.d/$$f";\
	done;
