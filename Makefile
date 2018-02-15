PWD = $(shell pwd)
# packages for my dev env, based on emacs
PACKAGES = emacs rustup rustfmt rust-racer coq
PG = v4.4.tar.gz
THEME = Flat-Pat-light-3.22.tar.gz

.PHONY: meslo omzsh urxvt nvim emacs emacspkg pg tmuxpkg tmux i3 i3pkg emacsconf xmonad

i3pkg:
	yaourt -S i3 dmenu nitrogen

xmonad:
	mkdir -p ${HOME}/.xmonad
	ln -sf ${PWD}/xmonad.hs ${HOME}/.xmonad/xmonad.hs
	ln -sf ${PWD}/xmobarrc ${HOME}/.xmobarrc
	sudo ln -sf ${PWD}/volumectl.sh /usr/local/bin/volumectl

i3:
	sudo cp ${PWD}/i3/i3-gnome.desktop /usr/share/applications/i3-gnome.desktop
	sudo cp ${PWD}/i3/i3-gnome-xsession.desktop /usr/share/xsessions/i3-gnome.desktop
	sudo cp ${PWD}/i3/i3-gnome.session /usr/share/gnome-session/sessions/i3-gnome.session
	mkdir -p ${HOME}/.config/i3
	nitrogen --save --set-auto ${PWD}/wallpaper.jpg || true
	ln -sf ${PWD}/i3.config ${HOME}/.config/i3/config
	sudo ln -sf ${PWD}/volumectl.sh /usr/local/bin/volumectl
	sudo ln -sf ${PWD}/i3/i3-gnome /usr/local/bin/i3-gnome

Xdefaults: Xdefaults.macros
	cpp Xdefaults.macros > Xdefaults

urxvt: omzsh Xdefaults
	yaourt -S ttf-meslo
	ln -sf   ${PWD}/zshrc      ${HOME}/.zshrc
	ln -sf   ${PWD}/Xdefaults  ${HOME}/.Xdefaults

emacs: pg emacsconf

emacsconf:
	ln -sf ${PWD}/emacs.d/init.el ${HOME}/.emacs.d/init.el
	ln -sf ${PWD}/emacs.d/emacs.d.org ${HOME}/.emacs.d/emacs.d.org
	sudo ln -sf ${PWD}/editor /usr/local/bin/editor

pg:
	mkdir -p ${HOME}/.emacs.d
	tar xvf ${PG} -C ${HOME}/.emacs.d/

emacspkg:
	yaourt -S ${PACKAGES}

omzsh:
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh > install.sh
	bash install.sh
	rm install.sh

nvim:
	mkdir -p ${HOME}/.config/
	ln -sf   ${PWD}/nvim       ${HOME}/.config/

tmux:
	ln -sf ${PWD}/tmux.conf    ${HOME}/.tmux.conf

tmuxpkg:
	yaourt -S tmux

gshell:
	mkdir -p ${HOME}/.themes
	tar xvf ${THEME} -C ${HOME}/.themes/
