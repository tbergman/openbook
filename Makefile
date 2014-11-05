include /usr/share/templar/Makefile

ALL:=$(TEMPLAR_ALL)
ALL_DEP:=$(TEMPLAR_ALL_DEP)
CLEAN:=

##############
# parameters #
##############
# do you want to show the commands executed ?
# Since we are using ?= for assignment it means that you can just
# set this from the command line and avoid changing the makefile...
DO_MKDBG?=0
# do you want to validate html?
DO_CHECKHTML:=1

########
# code #
########
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

HTMLCHECK:=html.stamp

ifeq ($(DO_CHECKHTML),1)
ALL+=$(HTMLCHECK)
CLEAN+=$(HTMLCHECK)
endif # DO_CHECKHTML

SOURCES_HTML:=index.html

#########
# rules #
#########

.DEFAULT_GOAL=all
.PHONY: all
all: $(ALL)
	$(info doing [$@])

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -xdf > /dev/null

.PHONY: checkhtml
checkhtml: $(HTMLCHECK)
	$(info doing [$@])

.PHONY: debug
debug:
	$(info doing [$@])
	$(info ALL is $(ALL))
	$(info ALL_DEP is $(ALL_DEP))
	$(info SOURCES_HTML is $(SOURCES_HTML))

$(HTMLCHECK): $(SOURCES_HTML) $(ALL_DEP)
	$(info doing [$@])
	$(Q)tidy -errors -q -utf8 $(SOURCES_HTML)
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(HTMLCHECK)
