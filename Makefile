RULESFILE=/usr/share/X11/xkb/rules/evdev

.PHONY: install
.ONESHELL:
install: altctl.map.gz
	@echo "Installing xkb keymap."
	install -m644 symbols/custom /usr/share/X11/xkb/symbols/
	echo "Enable option by adding 'custom:alt_ctl' to xkb options."
	echo "Installing virtual console keymap."
	install -m644 altctl.map.gz /usr/share/kbd/keymaps/
	echo "Enable with: loadkeys altctl"
	echo "Installing pacman hook to repatch after xkeyboard-layout update"
	install -m644 repatch-keyboard.hook /etc/pacman.d/hooks/
	echo "Put patcher into opt"
	mkdir -p /opt/alt_ctl
	sed "s@RULESFILE@$(RULESFILE)@g" patch_layout > /opt/alt_ctl/patch_layout
	chmod +x /opt/alt_ctl/patch_layout
	/opt/alt_ctl/patch_layout


.PHONY: uninstall
.ONESHELL:
uninstall:
	@rm /usr/share/X11/xkb/symbols/custom
	sed -i "/custom:alt_ctl/d" $(RULESFILE)
	echo "Remove custom:alt_ctl from any custom configuration."
	echo "Remove altctl.map.gz from /etc/vconsole.conf"
	rm /usr/share/kbd/keymaps/altctl.map.gz
	echo "Remove pacman hook"
	rm /etc/pacman.d/hooks/repatch-keyboard.hook
	echo "Remove repatcher"
	rm -r /opt/alt_ctl


altctl.map.gz: altctl.map
	gzip -k $<
