SUBPROJECTS := $(wildcard */.)
TOPTARGETS := all install clean

$(TOPTARGETS): $(SUBPROJECTS)

$(SUBPROJECTS):
	@echo -e "[\033[35;1m$(subst /.,,$@)\033[0m]"
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBPROJECTS)
