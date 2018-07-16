RULESFILE=/usr/share/X11/xkb/rules/evdev

.PHONY: install
install:
	@install -m644 symbols/custom /usr/share/X11/xkb/symbols/
	@./patch_custom $(RULESFILE)
	@echo "Enable option by adding 'custom:alt_ctl' to xkb options."

.PHONY: uninstall
uninstall:
	@rm /usr/share/X11/xkb/symbols/custom
	@sed -i "/custom:alt_ctl/d" $(RULESFILE)
	@echo "Remove custom:alt_ctl from any custom configuration."
