XML_PATH = gr-mods/grc
CC_PATH = gr-mods/lib
PY_PATH = gr-mods/python
H_PATH = gr-mods/include/mods

HIER_FILES = $(shell find grc/hier/ -type f -name '*.grc')
HIER_PY_FILES = $(patsubst grc/hier/%.grc, gr-mods/python/%.py, $(HIER_FILES))

GRC_FILES = $(shell find grc/ -maxdepth 1 -type f -name '*.grc')
GRC_PY_FILES = $(patsubst grc/%.grc, grc/%.py, $(GRC_FILES))

MOD_XML = $(shell find $(XML_PATH) -type f -name '*.xml')
MOD_I_H = $(shell find $(CC_PATH) -type f -name '*.h')
MOD_CC = $(shell find $(CC_PATH) -type f -name '*.cc')
MOD_PY = $(shell find $(PY_PATH) -type f -name '*.py')
MOD_H = $(shell find $(H_PATH) -type f -name '*.h')

GR_FRAMERS = gr-framers/build_record
GR_MODS = gr-mods/build_record

.PHONY: mods gr-framers rx-lower rx-upper rx-gui rx

# Build Rx Flowgraphs
build: $(GR_FRAMERS) $(GR_MODS) $(HIER_PY_FILES) $(GRC_PY_FILES)

grc/%.py: grc/%.grc
	grcc $< -d $(@D)

# Build Hierarchical Blocks
build-hier: $(HIER_PY_FILES)

gr-mods/python/%.py: grc/hier/%.grc
	grcc $<
	mv $(HOME)/.grc_gnuradio/$(@F) gr-mods/python/
	mv $(HOME)/.grc_gnuradio/$(@F).xml gr-mods/grc/mods_$(*F).xml

# Build GR Framers
gr-framers: $(GR_FRAMERS)

$(GR_FRAMERS):
	./install_gr_framers.sh

# Build GR Mods
mods: $(GR_MODS)

$(GR_MODS): $(MOD_CC) $(MOD_I_H) $(MOD_H) $(MOD_XML) $(MOD_PY)
	./install_mods.sh

# Run Rx Flowgraphs
rx-lower: grc/rx_lower.py
	python grc/rx_lower.py

rx-upper: grc/rx_upper.py
	python grc/rx_upper.py

rx-gui: grc/rx_gui.py
	python grc/rx_gui.py

rx: grc/rx.py
	python grc/rx.py
