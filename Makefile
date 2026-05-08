.PHONY: all dotnet odin run run-odin compare compare-diff compare-cmp clean

DOTNET ?= dotnet
ODIN ?= odin
CONFIGURATION ?= Release
DOTNET_APP ?= $(DOTNET) run -c $(CONFIGURATION) --
ODIN_APP ?= ./bin/markovjunior-odin
COMPARE_MODEL ?= Basic
COMPARE_FORMAT ?= text
COMPARE_ARGS ?= --amount=1 --format=$(COMPARE_FORMAT)
COMPARE_TOOL ?= auto

all: dotnet odin

dotnet:
	$(DOTNET) build -c $(CONFIGURATION)

odin:
	mkdir -p bin
	$(ODIN) build odin -out:bin/markovjunior-odin

run: dotnet
	$(DOTNET) run -c $(CONFIGURATION) -- Basic

run-odin: odin
	$(ODIN_APP)

compare: all
	rm -rf tmp/dotnet tmp/odin
	mkdir -p tmp/dotnet tmp/odin
	$(DOTNET_APP) $(COMPARE_MODEL) $(COMPARE_ARGS) --output=tmp/dotnet
	$(ODIN_APP) $(COMPARE_MODEL) $(COMPARE_ARGS) --output=tmp/odin
	@if [ "$(COMPARE_TOOL)" = "diff" ] || { [ "$(COMPARE_TOOL)" = "auto" ] && [ "$(COMPARE_FORMAT)" = "text" ]; }; then \
		$(MAKE) compare-diff; \
	else \
		$(MAKE) compare-cmp; \
	fi

compare-diff:
	diff -ru tmp/dotnet tmp/odin

compare-cmp:
	@cd tmp/dotnet && find . -type f | sort > ../dotnet-files.txt
	@cd tmp/odin && find . -type f | sort > ../odin-files.txt
	diff -u tmp/dotnet-files.txt tmp/odin-files.txt
	@while IFS= read -r file; do \
		cmp "tmp/dotnet/$$file" "tmp/odin/$$file" || exit $$?; \
	done < tmp/dotnet-files.txt

clean:
	$(DOTNET) clean
	rm -rf output tmp bin/markovjunior-odin bin/markovjunior-odin.dSYM
