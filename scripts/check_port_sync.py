#!/usr/bin/env python3
"""Check that odin/ mirrors source/ file names for the 1:1 port.

Allowed Odin-only files are infrastructure entrypoints, not C# source mirrors.
"""
from pathlib import Path
import sys

SOURCE_DIR = Path("source")
ODIN_DIR = Path("odin")
ALLOWED_ODIN_ONLY = {"main"}

source = {p.stem for p in SOURCE_DIR.glob("*.cs")}
odin = {p.stem for p in ODIN_DIR.glob("*.odin")}

missing = sorted(source - odin)
extra = sorted(odin - source - ALLOWED_ODIN_ONLY)

if missing:
    print("Missing Odin mirror files:")
    for name in missing:
        print(f"  odin/{name}.odin for source/{name}.cs")
if extra:
    print("Unexpected Odin-only files:")
    for name in extra:
        print(f"  odin/{name}.odin")

if not missing and not extra:
    print(f"source/ and odin/ are in sync: {len(source)} mirrored files, {len(ALLOWED_ODIN_ONLY & odin)} Odin-only infrastructure file(s).")
    sys.exit(0)

sys.exit(1)
