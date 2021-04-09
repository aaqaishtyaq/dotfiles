CONFIG_PATH = $(HOME)/.config

.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "Please Use individual modules";

.PHONY: alacritty
## alacritty: terminal emulator written in rust
alacritty:
	@ALACRITTY_PATH="$(HOME)/.config/alacritty"
	@mkdir -p $(ALACRITTY_PATH)
	@ln -fs "$(CURDIR)/config/alacritty/alacritty.yml" $(ALACRITTY_PATH)

.PHONY: dircolors
## dircolors: color setup for ls
dircolors:
	@mkdir -p "$(CONFIG_PATH)/dircolors"
	@ln -sf "$(CURDIR)/config/dircolors/dircolors" "$(CONFIG_PATH)/dircolors/dircolors"

.PHONY: startship
## startship: prompt written in rust
startship:
	@cd config/startship
	@./setup

.PHONY: zsh
## zsh: the Z shell
zsh:
	@mkdir -p ${HOME}/.config/zsh.d/;
	@ln -fs "$(CURDIR)/config/zsh.d/.zshrc" "${HOME}/.zshrc";
	@for file in $(shell find $(CURDIR)/config/zsh.d -type f -name "*.zsh"); do \
		f=$$(basename $$file); \
		ln -fs $$file "${CONFIG_PATH}/zsh.d/$$f";\
	done;

.PHONY: help
## help: print the help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'
