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
    ("Backtracker", 0): "full",
    ("Digger", 0): "steps=100",
    ("MazeBacktracker", 0): "steps=100",
    ("RegularSAWRestart", 0): "steps=100",
    ("SAWRestart", 0): "steps=100",
    ("NoDeadEnds", 0): "full",
    ("NoDeadEnds", 1): "steps=100",
    ("PutColoredLs", 0): "full",
    ("BasicPartitioning", 0): "full",
    ("BacktrackerCycle", 0): "full",
    ("GrowthCompetition", 0): "steps=200",
    ("LoopGrowth", 0): "steps=200",
    ("SmoothTrail", 0): "steps=200",
    ("StochasticVoronoi", 0): "steps=200",
    ("Voronoi", 0): "steps=200",
    ("River", 0): "steps=200",
    ("BasicBrickWall", 0): "full",
    ("MultiHeadedWalk", 0): "steps=200",
    ("Flowers", 0): "steps=200",
    ("HamiltonianPath", 0): "steps=200",
    ("HamiltonianPaths", 0): "steps=200",
    ("MultiHeadedWalkDungeon", 0): "steps=200",
    ("NystromDungeon", 0): "steps=200",
    ("Texture", 0): "steps=200",
    ("Forest", 0): "full",
    ("FireNoise", 0): "steps=200",
    ("MultiHeadedDungeon", 0): "steps=200",
    ("StrangeDungeon", 0): "steps=200",
    ("Tetris", 0): "steps=200",
    ("SmartSAW", 0): "steps=200",
    ("FindLongCycle", 0): "steps=200",
    ("DualRetraction", 0): "steps=500",
    ("GrowthContraction", 0): "steps=500",
    ("GrowthWalk", 0): "steps=500",
    ("IrregularMazeGrowth", 0): "steps=500",
    ("MazeBacktracker", 1): "steps=500",
    ("MazeGrowth", 0): "steps=500",
    ("MazeGrowth", 1): "steps=500",
    ("MazeTrail", 0): "steps=500",
    ("MazeTrail", 1): "steps=500",
    ("NestedGrowth", 0): "steps=500",
    ("Noise", 1): "steps=500",
    ("ParallelGrowth", 0): "steps=500",
    ("Push", 0): "steps=500",
    ("RainbowGrowth", 0): "steps=500",
    ("RegularSAW", 0): "steps=500",
    ("RegularSAW", 1): "steps=500",
    ("RegularSAWRestart", 1): "steps=500",
    ("River", 1): "steps=500",
    ("StochasticVoronoi", 1): "steps=500",
    ("StrangeDungeon", 1): "steps=500",
    ("Voronoi", 1): "steps=500",
    ("DualRetraction3D", 0): "steps=500",
    ("SokobanLevel1", 0): "steps=500",
    ("SokobanLevel2", 0): "steps=500",
    ("BasicDijkstraDungeon", 0): "steps=500",
    ("BasicDijkstraFill", 0): "steps=500",
    ("BernoulliPercolation", 0): "steps=500",
    ("Percolation", 0): "steps=500",
    ("SmarterDigger", 0): "steps=500",
    ("Circuit", 0): "steps=500",
    ("Cave", 0): "steps=100",
    ("CaveContour", 0): "steps=100",
    ("ConnectedCaves", 0): "steps=100",
    ("ConstrainedCaves", 0): "steps=100",
    ("Counting", 0): "steps=100",
    ("GameOfLife", 0): "steps=100",
    ("Hills", 0): "steps=100",
    ("OpenCave", 0): "steps=100",
    ("OpenCave3D", 0): "steps=100",
    ("BiasedGrowth", 0): "steps=200",
    ("BiasedMazeGrowth", 0): "steps=200",
    ("DenseSAW", 0): "steps=200",
    ("GrowTo", 0): "steps=200",
    ("StrangeNoise", 0): "steps=200",
    ("BiasedGrowthContraction", 0): "steps=200",
    ("BiasedVoronoi", 0): "steps=200",
    ("CentralCrawlers", 0): "steps=200",
    ("Coupling", 0): "steps=200",
    ("CrawlersChase", 0): "steps=200",
    ("Dwarves", 0): "steps=200",
    ("PaintCompetition", 0): "steps=200",
    ("Keys", 0): "steps=200",
    ("OrganicMechanic", 0): "steps=200",
    ("Division", 0): "steps=200",
    ("Rosettes", 0): "steps=200",
    ("SoftPath", 0): "steps=200",
    ("WolfBasedApproach", 0): "steps=200",
    ("DiagonalPath", 0): "steps=200",
    ("BishopParity", 0): "steps=200",
    ("SnellLaw", 0): "steps=200",
    ("StormySnellLaw", 0): "steps=200",
    ("EuclideanPath", 0): "steps=200",
    ("CrossCountry", 0): "steps=200",
    ("OddScale3D", 0): "steps=200",
    ("OddScale", 0): "steps=200",
    ("MarchingSquares", 0): "steps=200",
    ("MazeMap", 0): "steps=200",
    ("StairsPath", 0): "steps=200",
    ("ChainMaze", 0): "steps=200",
    ("ChainDungeon", 0): "steps=200",
    ("ChainDungeonMaze", 0): "steps=200",
    ("WaveBrickWall", 0): "steps=500",
    ("WaveFlowers", 0): "steps=500",
    ("WaveDungeon", 0): "steps=500",
    ("Sewers", 0): "steps=500",
    ("CarmaTower", 0): "steps=200",
    ("CarmaTower", 1): "steps=200",
    ("Island", 0): "steps=200",
    ("Keys", 1): "steps=200",
    ("LostCity", 0): "steps=200",
    ("SelectLargeCaves", 0): "steps=200",
    ("SoftPath", 1): "steps=200",
    ("BlueNoise", 0): "steps=200",
    ("CentralSAW", 0): "steps=200",
    ("Laplace", 0): "steps=200",
    ("ForestFireCA", 0): "steps=200",
    ("KnightPatrol", 0): "steps=200",
    ("RegularPath", 0): "steps=200",
    ("DijkstraDungeon", 0): "steps=200",
    ("DungeonGrowth", 0): "steps=200",
    ("CompleteSAW", 0): "steps=500",
    ("CompleteSAWSmart", 0): "steps=500",
    ("Knots2D", 0): "steps=500",
    ("TileDungeon", 0): "steps=500",
    ("TilePath", 0): "steps=500",
    ("Partitioning", 0): "steps=500",
}

KNOWN_FAIL = {
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

IMPLEMENTED_ROOTS = {"one", "all", "prl", "path", "convolution", "convchain", "map", "wfc", "sequence", "markov"}
IMPLEMENTED_TAGS = {"one", "all", "prl", "path", "convolution", "convchain", "field", "observe", "map", "wfc", "rule", "sequence", "union", "markov"}


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
        uses_file_rule = any("file" in elem.attrib or "fin" in elem.attrib or "fout" in elem.attrib for elem in xroot.iter())
        entries.append({
            "global_index": global_index,
            "model_index": model_index,
            "name": name,
            "model_attrs": dict(xmodel.attrib),
            "root": xroot.tag,
            "tags": tags,
            "path": path,
            "uses_file_rule": uses_file_rule,
        })
    return entries


def support_status(entry):
    key = (entry["name"], entry["model_index"])
    if key in PASS:
        return "PASS", PASS[key]
    if key in KNOWN_FAIL:
        return "TODO", KNOWN_FAIL[key]
    tags = set(entry["tags"])
    if any(elem.tag == "wfc" and "tileset" in elem.attrib for elem in ET.parse(entry["path"]).getroot().iter()):
        return "TODO", "tile-based WFC not ported yet"
    if entry["root"] in IMPLEMENTED_ROOTS and tags <= IMPLEMENTED_TAGS:
        if "markov" in tags:
            return "LIKELY", "markov subset implemented; needs compare or persistent all/prl support"
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
