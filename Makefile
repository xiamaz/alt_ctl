.PHONY: install
install:
	@install -m644 symbols/custom /usr/share/X11/xkb/symbols/
	@./patch_custom /usr/share/X11/xkb/rules/evdev
	@echo "Enable option by adding 'custom:alt_ctl' to xkb options."
