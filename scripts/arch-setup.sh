#!/usr/bin/env bash

pacman_install() {
  local pkg="$*"
  sudo pacman -Syu "${pkg}"
}

# install packages
#pacman_install base-devel
#pacman_install ttf-ibm-plex
