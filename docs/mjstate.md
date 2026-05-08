# MJSTATE Text Format

MJSTATE is a simple, deterministic, human-readable dump of a MarkovJunior grid state.
It is intended for debugging, tests, and `diff`-based comparison between ports.

It is not intended to replace PNG or VOX for visual output.

## File extension

Recommended extension:

```text
.mjstate
```

During early development `.txt` is also acceptable.

## Version 1

A version 1 file is UTF-8 text with LF line endings.

```text
MJSTATE 1
size <x> <y> <z>
legend <symbols>
[grid data]
```

Example 2D file:

```text
MJSTATE 1
size 4 3 1
legend BW
BWWB
BBBB
WWBB
```

Example 3D file:

```text
MJSTATE 1
size 3 2 2
legend BWG
z 0
BBW
GGG
z 1
WWW
BBG
```

## Header

### Magic/version

```text
MJSTATE 1
```

Identifies the file as MJSTATE version 1.

### Size

```text
size <x> <y> <z>
```

- `<x>`: grid width
- `<y>`: grid height
- `<z>`: grid depth

All values are positive decimal integers.

### Legend

```text
legend <symbols>
```

The legend maps byte values to printable symbols.

For example:

```text
legend BWG
```

Means:

```text
0 -> 'B'
1 -> 'W'
2 -> 'G'
```

Symbols should be single-byte printable ASCII characters for easy parsing and diffing.

## Grid data

Grid data is written in MarkovJunior's canonical order:

```text
index = x + y * size_x + z * size_x * size_y
```

For each `z` slice, rows are written from `y = 0` to `y = size_y - 1`.
Inside each row, columns are written from `x = 0` to `x = size_x - 1`.

For 2D grids where `z == 1`, the `z 0` slice marker is omitted.

For 3D grids where `z > 1`, each slice starts with:

```text
z <index>
```

followed by exactly `size_y` rows of exactly `size_x` symbols.

## Whitespace rules

Writers should emit:

- UTF-8
- LF line endings
- no trailing spaces
- one final newline at end of file

Readers may ignore empty lines after the required data, but should reject malformed grid rows.

## Use cases

MJSTATE is ideal for:

- comparing C# and Odin output with `diff -ru`
- reviewing small procedural outputs in Git
- deterministic regression tests
- isolating generator logic from renderer differences

## Non-goals

MJSTATE is not optimized for:

- file size
- fast loading of huge worlds
- color palettes
- renderer-specific metadata

For compact binary snapshots, use MJBIN instead.
