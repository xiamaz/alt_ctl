RULESFILE=/usr/share/X11/xkb/rules/evdev

.PHONY: install
.ONESHELL:
install: altctl.map.gz
	@echo "Installing xkb keymap."
	install -m644 symbols/custom /usr/share/X11/xkb/symbols/
	./patch_custom $(RULESFILE)
	echo "Enable option by adding 'custom:alt_ctl' to xkb options."
	echo "Installing virtual console keymap."
	install -m644 altctl.map.gz /usr/share/kbd/keymaps/
	echo "Enable with: loadkeys altctl"

.PHONY: uninstall
.ONESHELL:
uninstall:
	@rm /usr/share/X11/xkb/symbols/custom
	sed -i "/custom:alt_ctl/d" $(RULESFILE)
	echo "Remove custom:alt_ctl from any custom configuration."
	echo "Remove altctl.map.gz from /etc/vconsole.conf"
	rm /usr/share/kbd/keymaps/altctl.map.gz


altctl.map.gz: altctl.map
	gzip -k $<
