#!/usr/bin/env python3
import argparse
import collections
import os
import subprocess
import sys
import xml.etree.ElementTree as ET

PASS = {
    ("Basic", 0): "full",
    ("SelfAvoidingWalk", 0): "steps=100",
    ("StrangeGrowth", 0): "steps=100",
    ("IrregularSAW", 0): "steps=100",
    ("Trail", 0): "steps=100",
    ("PutLs", 0): "steps=5",
    ("ParallelMazeGrowth", 0): "full",
    ("ForestFire", 0): "steps=10",
    ("Growth", 0): "steps=100",
    ("Growth", 1): "full",
    ("Cycles", 0): "full",
    ("Noise", 0): "full",
    ("BasicDungeonGrowth", 0): "full",
}

PARTIAL = {
    ("Growth", 0): "2D duplicate selected by --model-index=0; tested to 100 steps",
    ("SelfAvoidingWalk", 0): "root <one>; tested to 100 steps",
    ("StrangeGrowth", 0): "root <one>; tested to 100 steps",
    ("IrregularSAW", 0): "root <one>; tested to 100 steps",
    ("Trail", 0): "root <one> with child rules; tested to 100 steps",
    ("PutLs", 0): "root <all>; tested to 5 steps",
    ("ForestFire", 0): "root <prl>; tested to 10 steps",
}

IMPLEMENTED_ROOTS = {"one", "all", "prl", "sequence"}
IMPLEMENTED_TAGS = {"one", "all", "prl", "rule", "sequence", "union"}


def model_entries():
    root = ET.parse("models.xml").getroot()
    seen = collections.Counter()
    entries = []
    for global_index, xmodel in enumerate(root.findall("model")):
        name = xmodel.attrib["name"]
        model_index = seen[name]
        seen[name] += 1
        path = f"models/{name}.xml"
        if not os.path.exists(path):
            continue
        xroot = ET.parse(path).getroot()
        tags = collections.Counter(elem.tag for elem in xroot.iter())
        entries.append({
            "global_index": global_index,
            "model_index": model_index,
            "name": name,
            "model_attrs": dict(xmodel.attrib),
            "root": xroot.tag,
            "tags": tags,
            "path": path,
        })
    return entries


def support_status(entry):
    key = (entry["name"], entry["model_index"])
    if key in PASS:
        return "PASS", PASS[key]
    tags = set(entry["tags"])
    if entry["root"] in IMPLEMENTED_ROOTS and tags <= IMPLEMENTED_TAGS:
        return "LIKELY", "root node subset implemented; needs compare"
    missing = sorted(tags - IMPLEMENTED_TAGS)
    if entry["root"] not in IMPLEMENTED_ROOTS:
        missing = sorted(set(missing + [entry["root"]]))
    return "TODO", ", ".join(missing) if missing else "needs compare"


def write_markdown(entries, path):
    counts = collections.Counter(support_status(e)[0] for e in entries)
    unique_files = len({e["path"] for e in entries})
    with open(path, "w") as f:
        f.write("# Model Port Status\n\n")
        f.write("Tracks `models/*.xml` coverage for the Odin port.\n\n")
        f.write("## Summary\n\n")
        f.write(f"- `models.xml` entries with files: {len(entries)}\n")
        f.write(f"- unique model XML files: {unique_files}\n")
        f.write(f"- passing/recorded: {counts['PASS']}\n")
        f.write(f"- likely supported but unverified: {counts['LIKELY']}\n")
        f.write(f"- TODO / unsupported: {counts['TODO']}\n\n")
        f.write("## Legend\n\n")
        f.write("- `PASS`: compared successfully with C# for the note shown.\n")
        f.write("- `LIKELY`: root/tag subset exists in Odin, but compare has not been recorded.\n")
        f.write("- `TODO`: requires unsupported node types or features.\n\n")
        f.write("## Entries\n\n")
        f.write("| Status | Model | model-index | Root | Tags | Note |\n")
        f.write("|---|---:|---:|---|---|---|\n")
        for e in entries:
            status, note = support_status(e)
            tags = " ".join(f"{k}:{v}" for k, v in sorted(e["tags"].items()))
            f.write(f"| {status} | `{e['name']}` | {e['model_index']} | `{e['root']}` | `{tags}` | {note} |\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--write", default="MODEL_STATUS.md")
    args = ap.parse_args()
    entries = model_entries()
    write_markdown(entries, args.write)
    print(f"wrote {args.write}")


if __name__ == "__main__":
    main()
