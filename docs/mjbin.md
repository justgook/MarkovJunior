# MJBIN Binary Grid Format

MJBIN is a proposed compact binary format for deterministic MarkovJunior grid snapshots.
It stores the raw grid values, dimensions, and legend without renderer-specific data.

This document describes the intended version 1 layout. The implementation may come later.

## File extension

Recommended extension:

```text
.mjbin
```

## Goals

MJBIN should be:

- deterministic
- simple to implement in C#, Odin, and C
- suitable for byte-for-byte comparison
- faster and smaller than MJSTATE text files
- independent from PNG and VOX rendering

## Version 1 byte layout

All integers are little-endian.

```text
Offset  Size  Description
0       4     Magic bytes: "MJB1"
4       4     size_x: u32
8       4     size_y: u32
12      4     size_z: u32
16      4     legend_count: u32
20      N     legend bytes, N = legend_count
20+N    M     state bytes, M = size_x * size_y * size_z
```

## Magic

The file starts with four bytes:

```text
4D 4A 42 31
```

ASCII:

```text
MJB1
```

This means MarkovJunior Binary version 1.

## Dimensions

The dimensions are unsigned 32-bit integers:

```text
size_x: u32
size_y: u32
size_z: u32
```

The number of cells is:

```text
cell_count = size_x * size_y * size_z
```

Readers should reject files where this multiplication overflows their addressable memory.

## Legend

The legend is stored as raw bytes:

```text
legend_count: u32
legend: [legend_count]u8
```

The legend maps state byte values to symbols:

```text
0 -> legend[0]
1 -> legend[1]
2 -> legend[2]
...
```

For compatibility with MJSTATE, legend bytes should usually be printable ASCII.

## State data

State data is stored as raw `u8` cell values.

The order is the same as the C# implementation:

```text
index = x + y * size_x + z * size_x * size_y
```

Total state byte count:

```text
size_x * size_y * size_z
```

Each state byte must be less than `legend_count`.

## Example

For a 4x3x1 grid with legend `BW` and 12 cells, the structure is:

```text
MJB1
u32 4
u32 3
u32 1
u32 2
bytes "BW"
12 state bytes
```

If the visual grid is:

```text
BWWB
BBBB
WWBB
```

Then state bytes are:

```text
0 1 1 0  0 0 0 0  1 1 0 0
```

## Comparison

MJBIN files are suitable for direct byte comparison:

```bash
cmp a.mjbin b.mjbin
```

or recursive comparison:

```bash
diff -ru tmp/dotnet tmp/odin
```

## Relationship to other formats

- MJSTATE: human-readable text format for debugging and diffs.
- MJBIN: compact canonical binary state format.
- PNG: rendered visual preview for 2D output.
- VOX: MagicaVoxel-compatible 3D visual/export format.

MJBIN stores generator state, not final rendering.
