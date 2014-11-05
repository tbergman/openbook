include /usr/share/templar/Makefile

ALL:=$(TEMPLAR_ALL)
ALL_DEP:=$(TEMPLAR_ALL_DEP)

##############
# parameters #
##############
# do you want to show the commands executed ?
# Since we are using ?= for assignment it means that you can just
# set this from the command line and avoid changing the makefile...
DO_MKDBG?=0

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

.PHONY: debug
debug:
	$(info doing [$@])
	$(info ALL is $(ALL))
	$(info ALL_DEP is $(ALL_DEP))
