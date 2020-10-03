SUBPROJECTS := $(wildcard */.)
TOPTARGETS := all install clean

$(TOPTARGETS): $(SUBPROJECTS)

$(SUBPROJECTS):
	@echo "[\033[32m$(subst /.,,$@)\033[0m]"
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBPROJECTS)
