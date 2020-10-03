SCRIPTS:=$(wildcard *.sh)
INSTALL_PATH:=$(HOME)/.local/bin/

all: ;

clean: ;

install: $(SCRIPTS)

$(SCRIPTS):
	cp -f $@ $(addprefix $(INSTALL_PATH), $(basename $@))
	chmod +x $(addprefix $(INSTALL_PATH), $(basename $@))

.PHONY: all install clean $(SCRIPTS)
