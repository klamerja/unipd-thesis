TYPST     ?= typst
FONTS     := src/assets/fonts
OUT       := output/pdf
FLAGS     := --root . --font-path $(FONTS)

.PHONY: all build pdfa watch test clean

all: build

build: | $(OUT)
	$(TYPST) compile $(FLAGS) index.typ $(OUT)/index.pdf

pdfa: | $(OUT)
	$(TYPST) compile $(FLAGS) --pdf-standard a-2a index.typ $(OUT)/index-pdfa.pdf

watch: | $(OUT)
	$(TYPST) watch $(FLAGS) index.typ $(OUT)/index.pdf

# Mirrors the checks run in .github/workflows/typst.yml.
test: | $(OUT)
	$(TYPST) compile $(FLAGS) index.typ $(OUT)/test-index.pdf
	$(TYPST) compile $(FLAGS) tests/en.typ $(OUT)/test-en.pdf
	$(TYPST) compile $(FLAGS) --pdf-standard a-2a index.typ $(OUT)/test-pdfa.pdf
	@if $(TYPST) compile $(FLAGS) tests/invalid-acronyms.typ $(OUT)/test-invalid.pdf 2>/dev/null; then \
		echo "Expected invalid acronym definitions to fail validation"; exit 1; fi
	@if $(TYPST) compile $(FLAGS) tests/invalid-glossary.typ $(OUT)/test-invalid.pdf 2>/dev/null; then \
		echo "Expected invalid glossary entries to fail validation"; exit 1; fi
	@rm -f $(OUT)/test-*.pdf
	@echo "All checks passed."

$(OUT):
	mkdir -p $@

clean:
	rm -f $(OUT)/index.pdf $(OUT)/index-pdfa.pdf $(OUT)/test-*.pdf
