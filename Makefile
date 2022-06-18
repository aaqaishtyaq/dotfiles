CONFIG_PATH = $(HOME)/.config

.PHONY: help
## help: print the help message
help:
	@echo "Usage:\n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: dotfiles
## dotfiles: setup symlinks for dotfiles
dotfiles:
	@echo "Please Use individual modules";

.PHONY: alacritty
## alacritty: terminal emulator written in rust
alacritty:
	@mkdir -p $(CONFIG_PATH)/alacritty;
	@ln -fs "$(CURDIR)/config/alacritty/alacritty.yml" $(CONFIG_PATH)/alacritty/alacritty.yml;

.PHONY: asdf
## asdf: setup asdf tools version
asdf:
	@ln -sf "$(CURDIR)/config/asdf/.tool-versions" "$(HOME)/.tool-versions"

.PHONY: dircolors
## dircolors: color setup for ls
dircolors:
	@mkdir -p "$(CONFIG_PATH)/dircolors"
	@ln -sf "$(CURDIR)/config/dircolors/dircolors" "$(CONFIG_PATH)/dircolors/dircolors"

.PHONY: git
## git: setup git template
git:
	@ln -sf "$(CURDIR)/config/git/.git-template" "$(HOME)/.git-template"

.PHONY: hammerspoon
## hammerspoon: control mac using lua
hammerspoon:
	# Set default hammerspoon config localtion to XDG_HOME
	@defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	@mkdir -p "$(CONFIG_PATH)/hammerspoon"
	@ln -sf "$(CURDIR)/config/hammerspoon/init.lua" "$(CONFIG_PATH)/hammerspoon/init.lua"
	@ln -sf "$(CURDIR)/config/hammerspoon/window-management.lua" "$(CONFIG_PATH)/hammerspoon/window-management.lua"

.PHONY: nvim
## nvim: control mac using lua
nvim:
	@mkdir -p "$(CONFIG_PATH)/nvim"
	@ln -sf "$(CURDIR)/config/nvim/init.vim" "$(CONFIG_PATH)/nvim/init.vim"

.PHONY: starship
## starship: prompt written in rust
starship:
	@bash config/starship/setup

.PHONY: tmux
## tmux: vanilla tmux config
tmux:
	@ln -fs "$(CURDIR)/config/tmux/next/tmux.conf" "${HOME}/.tmux.conf"

.PHONY: zsh
## zsh: the Z shell
zsh:
	@mkdir -p ${HOME}/.config/zsh.d/lib/cache;
	@ln -fs "$(CURDIR)/config/zsh.d/.zshrc" "${HOME}/.zshrc";
	@for file in $(shell find $(CURDIR)/config/zsh.d -type f -name "*.zsh"); do \
		f=$$(basename $$file); \
		ln -fs $$file "${CONFIG_PATH}/zsh.d/$$f";\
	done;

.PHONY: limelight
## limelight: show borders around macOS window
limelight:
	@if [[ $(shell uname) == Darwin ]]; then \
		mkdir -p "${CONFIG_PATH}/limelight"; \
		echo "Created config directory"; \
		echo "Symlinking config"; \
		ln -sf "$(CURDIR)/config/limelight/limelightrc" "${CONFIG_PATH}/limelight/limelightrc"; \
	fi

