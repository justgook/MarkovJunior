# MarkovJunior C# -> Odin Port TODO

Goal: keep the Odin port behavior-compatible with the C# implementation, using `make compare` as the gate.

## Current status

- [x] Nix shell with .NET 10 and Odin: `shell.nix`
- [x] Makefile builds both projects: `make`
- [x] Compare pipeline: `make compare`
- [x] Text state comparison format: `--format=text`
- [x] Format docs:
  - [x] `docs/mjstate.md`
  - [x] `docs/mjbin.md`
- [x] Deterministic PRNG in C#: `source/MJRandom.cs`
- [x] Matching deterministic PRNG in Odin: `odin/MJRandom.odin`
- [x] Odin file skeletons matching `source/*.cs`
- [x] First Odin model implemented through minimal XML `<one>` path: `Basic`
- [x] `Basic` passes `make compare`
- [~] Minimal Odin XML loader/interpreter started for root `<one>` models
- [x] Several root `<one>` models pass compare with limited steps: `SelfAvoidingWalk`, `StrangeGrowth`, `IrregularSAW`, `Trail`

## Copied / ported files

### Complete enough for current tests

- [x] `source/MJRandom.cs` -> `odin/MJRandom.odin`
- [~] `source/Program.cs` -> `odin/main.odin`
  - CLI bootstrap exists.
  - Supports `Basic`, `--amount=`, `--output=`, `--format=text`.
  - Does not yet parse `models.xml`.

### Placeholder files created, still need real ports

- [ ] `ArrayHelper.cs` -> `ArrayHelper.odin`
- [~] `Grid.cs` -> `Grid.odin`
  - Basic state/dimensions/legend/origin/matching implemented.
- [~] `Rule.cs` -> `Rule.odin`
  - Basic inline `in`/`out` pattern parsing implemented.
  - 2D square symmetry expansion implemented for default root `<one>` rules.
  - 3D cube symmetry expansion not implemented yet.
- [ ] `RuleNode.cs` -> `RuleNode.odin`
- [~] `OneNode.cs` -> `OneNode.odin`
  - Initial scan, random stale-match removal, apply, and incremental add-around-changes implemented for simple rules.
- [ ] `AllNode.cs` -> `AllNode.odin`
- [ ] `ParallelNode.cs` -> `ParallelNode.odin`
- [ ] `Node.cs` -> `Node.odin`
- [ ] `Interpreter.cs` -> `Interpreter.odin`
- [ ] `XMLHelper.cs` -> `XMLHelper.odin`
- [ ] `SymmetryHelper.cs` -> `SymmetryHelper.odin`
- [ ] `Graphics.cs` -> `Graphics.odin`
- [ ] `VoxHelper.cs` -> `VoxHelper.odin`
- [ ] `Field.cs` -> `Field.odin`
- [ ] `Observation.cs` -> `Observation.odin`
- [ ] `Search.cs` -> `Search.odin`
- [ ] `Path.cs` -> `Path.odin`
- [ ] `Convolution.cs` -> `Convolution.odin`
- [ ] `ConvChain.cs` -> `ConvChain.odin`
- [ ] `Map.cs` -> `Map.odin`
- [ ] `WaveFunctionCollapse.cs` -> `WaveFunctionCollapse.odin`
- [ ] `OverlapModel.cs` -> `OverlapModel.odin`
- [ ] `TileModel.cs` -> `TileModel.odin`
- [ ] `GUI.cs` -> `GUI.odin`

## Next models to target

The easiest next models are `one`-only models because they need the same core as `Basic` but with larger patterns and origin handling.

Suggested order:

1. [x] `Basic`
   - `<one values="BW" in="B" out="W"/>`
2. [~] `Growth`
   - `<one values="BW" origin="True" in="WB" out="WW"/>`
   - Core behavior works, but the `models.xml` duplicate 2D/3D entries make current name-based compare unsuitable until compare selection is improved.
3. [ ] `RegularSAW`
   - `<one values="BRW" origin="True" in="RBB" out="WWR"/>`
   - Needs multiple values and longer 1D pattern.
4. [ ] `MazeGrowth`
   - Needs slash-separated 2D patterns, e.g. `WBB=WAW`.
5. [ ] `GrowthContraction` / `Trail` / `MazeTrail`
   - Need multiple `<rule>` children inside one `one` node.

## Immediate implementation tasks

To move beyond hard-coded `Basic`, implement this minimal core:

- [~] XML loading in Odin
  - [x] Parse `models.xml` enough to find model by name.
  - [x] Parse `models/<name>.xml` root `<one>` attributes.
  - [x] Supported attributes first: `values`, `origin`, `in`, `out`, `steps`, `size`, `d`, `length`, `width`, `height`.
  - [ ] Handle duplicate model entries in `models.xml` exactly like C# or add a compare selector.
- [~] `Grid`
  - [x] `state: []u8`
  - [x] dimensions `MX`, `MY`, `MZ`
  - [x] `characters` legend
  - [x] map char -> value index by lookup
  - [ ] `clear()`
  - [x] origin initialization
- [~] `Rule`
  - [x] Parse pattern strings.
  - [x] Support `/` row separators.
  - [x] Support `*` wildcard in input.
  - [x] Support `*` no-change in output.
  - [x] Store `input` as bit masks, like C#.
  - [x] Store `output` as `u8`, with `0xff` as no-change.
  - [x] Implement 2D square symmetry expansion from `SymmetryHelper.cs` / `Rule.Symmetries`.
  - [ ] Implement 3D cube symmetry expansion from `SymmetryHelper.cs` / `Rule.Symmetries`.
- [~] `OneNode`
  - [x] Initial full match scan.
  - [x] Random match selection/removal matching C# order.
  - [x] Apply selected rule.
  - [x] Stop when no matches or step limit reached.
  - [x] Incrementally add matches around changed cells.
  - [x] Validate against symmetric rules after symmetry expansion for several 2D models.
- [ ] Text output
  - [ ] Rename `.txt` to `.mjstate` once both sides agree.
  - [ ] Keep exact final newline behavior.

## Compare tasks

- [x] `COMPARE_FORMAT=text` uses `diff -ru`.
- [x] Binary/VOX-style compare can use `COMPARE_TOOL=cmp`.
- [ ] Add `--format=mjbin` to C#.
- [ ] Add `--format=mjbin` to Odin.
- [ ] Add `COMPARE_FORMAT=mjbin COMPARE_TOOL=cmp` test.
- [ ] Add `COMPARE_FORMAT=vox COMPARE_TOOL=cmp` once Odin writes VOX.

## Format tasks

- [x] Document MJSTATE text format.
- [x] Document MJBIN binary format proposal.
- [ ] Implement `.mjstate` extension instead of `.txt`.
- [ ] Implement MJBIN writer in C#.
- [ ] Implement MJBIN writer in Odin.
- [ ] Implement optional MJBIN reader/test tool.

## Important compatibility notes

- RNG must use `MJRandom`, not language defaults.
- Grid index order must remain:

```text
index = x + y * MX + z * MX * MY
```

- C# `Basic` currently uses generated seed `1559595546` when `amount=1` and meta seed `0`.
- For exact comparison, output should compare grid state, not PNG rendering.
- PNG is useful for humans, but MJSTATE/MJBIN should be the canonical porting formats.
