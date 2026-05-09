# Source/Odin Port Sync

The Odin port mirrors C# source file names one-to-one:

```text
source/Foo.cs  ->  odin/Foo.odin
```

Rules:

- Do not add Odin implementation files that do not correspond to a `source/*.cs` file, except infrastructure entrypoints explicitly allowed by `scripts/check_port_sync.py`.
- If C# has multiple classes in one file, keep their Odin port in the matching Odin file. Example: C# `SequenceNode` and `MarkovNode` live in `source/Node.cs`, so their Odin implementation lives in `odin/Node.odin`.
- Keep generated output formats/helpers with the closest matching C# file. Example: text output helper is in `odin/Program.odin` because the C# CLI/output path is in `source/Program.cs`.
- Do not change `source/` just to improve symmetry; only move Odin code to the matching file.

Check sync with:

```bash
nix-shell --run 'make port-sync'
```

Allowed Odin-only files currently:

- `odin/main.odin` — Odin binary entrypoint/bootstrap.
