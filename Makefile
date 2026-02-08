SHELL := /bin/bash
LATEXMK = ./script/latex-wrapper.sh
LATEXMK_FLAGS = -pdf

# Git tracking
GIT = .git/HEAD .git/index

# Export for latexmkrc and wrapper script
export FINAL
export INTERACTIVE
export VERBOSE

# Verbosity control
ifndef VERBOSE
    LATEXMK_FLAGS += -silent
endif

ifdef INTERACTIVE
    LATEXMK_FLAGS += -interaction=nonstopmode
    VERBOSE = 1
endif

ALL=$(shell find . -name '*.tex' ! -name 'macros.tex')
all: $(ALL:.tex=.pdf)

# Main PDF targets - latexmk handles dependencies automatically
# Removed tidy from individual targets for parallel safety
.PRECIOUS: %.pdf
%.pdf: $(GIT) $(QUESTIONS) $(EXPERIMENTS) macros.tex %.tex
	$(LATEXMK) $(LATEXMK_FLAGS) $*.tex

# Cleanup - now separate from compilation for parallel safety
.PHONY: tidy
tidy:
	$(RM) */{*.out,*.log,*.aux,*.synctex.gz,*.blg,*.toc,*.fls,*.fdb_latexmk,*.nav,*.snm}
	$(RM) */{*Notes.bib}

# We can clean up, deleting even the generated template.tex and .pdf, and the .bbl
.PHONY: clean
clean: tidy
	$(RM) -r */*-template.{tex,pdf}
	$(RM) */*.bbl
	latexmk -c 2>/dev/null || true

distclean: clean
	$(RM) -r */*.pdf
	$(RM) graph-paper.zip graph-paper.tar.gz
	latexmk -C 2>/dev/null || true

.PHONY: graph-paper.zip graph-paper.tar.gz
graph-paper.zip: all
	find . -name '*.pdf' -type f | zip -@ graph-paper.zip

graph-paper.tar.gz: all
	find . -name '*.pdf' -type f | tar -czf graph-paper.tar.gz -T -

