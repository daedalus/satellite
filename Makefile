GRC_FILES = $(shell find grc/ -type f -name '*.grc')
PY_FILES = $(patsubst grc/%.grc, grc/%.py, $(GRC_FILES))

.PHONY: build install rx-lower rx-upper rx-gui rx

build: $(PY_FILES)

grc/%.py: grc/%.grc
	grcc $< -d $(@D)

install:
	./install_gr_framers.sh
	./install_mods.sh

rx-lower: grc/rx_lower.py
	python grc/rx_lower.py

rx-upper: grc/rx_upper.py
	python grc/rx_upper.py

rx-gui: grc/rx_gui.py
	python grc/rx_gui.py

rx: grc/rx.py
	python grc/rx.py
