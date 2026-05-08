.PHONY: all dotnet odin run run-odin compare clean

DOTNET ?= dotnet
ODIN ?= odin
CONFIGURATION ?= Release
DOTNET_APP ?= $(DOTNET) run -c $(CONFIGURATION) --
ODIN_APP ?= ./bin/markovjunior-odin
COMPARE_MODEL ?= Basic
COMPARE_ARGS ?= --amount=1 --format=text

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
	diff -ru tmp/dotnet tmp/odin

clean:
	$(DOTNET) clean
	rm -rf output tmp bin/markovjunior-odin bin/markovjunior-odin.dSYM
