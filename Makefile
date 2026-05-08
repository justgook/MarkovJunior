.PHONY: all dotnet odin run clean

DOTNET ?= dotnet
ODIN ?= odin
CONFIGURATION ?= Release

all: dotnet odin

dotnet:
	$(DOTNET) build -c $(CONFIGURATION)

# Placeholder for the future Odin port.
odin:
	@echo "Odin port not implemented yet; skipping."

run: dotnet
	$(DOTNET) run -c $(CONFIGURATION) -- Basic

clean:
	$(DOTNET) clean
	rm -rf output
