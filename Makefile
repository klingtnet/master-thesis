.PHONY: sync

PROJ_ROOT=$(PWD)
DOC_PATH=$(PROJ_ROOT)/doc
OUT_PATH=$(PROJ_ROOT)/out
BUILD_PATH=$(PROJ_ROOT)/build

LATEX_ENGINE=xelatex

PANDOC_OPTS=--from=markdown\
			--to=latex\
			--smart\
			--chapters

# batchmode does not print anything, this makes debugging on a CI impossible
XELATEX_CI_OPTS=-interaction=nonstopmode

# := is expanded once, see https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors
MD_FILES := $(wildcard $(DOC_PATH)/content*.md | sort)

all: $(OUT_PATH)/thesis.pdf $(OUT_PATH)/thesis.html

# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
$(DOC_PATH)/text.md: $(MD_FILES)
	@echo $^
	cat $^ > $(DOC_PATH)/text.md

$(DOC_PATH)/text.tex: $(DOC_PATH)/text.md
	pandoc --latex-engine=$(LATEX_ENGINE) $(PANDOC_OPTS) $(DOC_PATH)/text.md --output $@

$(OUT_PATH)/thesis.html: $(DOC_PATH)/text.md
	pandoc --standalone --mathjax --output $@ $<

# Setting `-output-directory` to prevent the cruft won't help,
# because biber and makeglossaries don't have that flag.
# The current solution is to `rsync` the document into a temporary build folder
# and to copy the generated `pdf` into the output folder.
# This works very well and you can `rm -r` the content of build folder with all the cruft.
$(OUT_PATH)/thesis.pdf: $(DOC_PATH)/text.tex
	mkdir -p $(OUT_PATH)
	mkdir -p $(BUILD_PATH)
	rsync --quiet --update --recursive $(DOC_PATH)/ $(BUILD_PATH)
	cd $(BUILD_PATH) && xelatex $(XELATEX_CI_OPTS) -no-pdf thesis
	cd $(BUILD_PATH) && biber thesis
	cd $(BUILD_PATH) && xelatex $(XELATEX_CI_OPTS) thesis
	cp $(BUILD_PATH)/thesis.pdf $(OUT_PATH)
	#makeglossaries $(BUILD_PATH)/glossary &&

open: $(OUT_PATH)/thesis.pdf
	xdg-open $<

clean:
	rm -f $(DOC_PATH)/text.tex
	rm -f $(DOC_PATH)/text.md
# I could use the $(BUILD_PATH) variable at this point, but if it expands to "" we will be really sad :( Also I am a coward because I don't use rm -r with variable arguments
	rm -r build/* out/*
