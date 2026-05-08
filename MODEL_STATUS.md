# Model Port Status

Tracks `models/*.xml` coverage for the Odin port.

## Summary

- `models.xml` entries with files: 155
- unique model XML files: 137
- passing/recorded: 13
- likely supported but unverified: 28
- TODO / unsupported: 114

## Legend

- `PASS`: compared successfully with C# for the note shown.
- `LIKELY`: root/tag subset exists in Odin, but compare has not been recorded.
- `TODO`: requires unsupported node types or features.

## Entries

| Status | Model | model-index | Root | Tags | Note |
|---|---:|---:|---|---|---|
| TODO | `Apartemazements` | 0 | `sequence` | `all:6 prl:16 rule:28 sequence:1 wfc:1` | wfc |
| TODO | `Apartemazements` | 1 | `sequence` | `all:6 prl:16 rule:28 sequence:1 wfc:1` | wfc |
| TODO | `CarmaTower` | 0 | `sequence` | `all:68 convolution:2 map:1 markov:12 one:41 path:5 prl:33 rule:178 sequence:2 union:11` | convolution, map, markov, path |
| TODO | `CarmaTower` | 1 | `sequence` | `all:68 convolution:2 map:1 markov:12 one:41 path:5 prl:33 rule:178 sequence:2 union:11` | convolution, map, markov, path |
| TODO | `ModernHouse` | 0 | `sequence` | `all:29 map:2 markov:8 one:27 path:4 prl:100 rule:352 sequence:1 union:18 wfc:2` | map, markov, path, wfc |
| TODO | `ModernHouse` | 1 | `sequence` | `all:29 map:2 markov:8 one:27 path:4 prl:100 rule:352 sequence:1 union:18 wfc:2` | map, markov, path, wfc |
| TODO | `SeaVilla` | 0 | `sequence` | `all:27 field:2 map:1 markov:8 one:29 path:7 prl:41 rule:236 sequence:1 union:5 wfc:1` | field, map, markov, path, wfc |
| TODO | `SeaVilla` | 1 | `sequence` | `all:27 field:2 map:1 markov:8 one:29 path:7 prl:41 rule:236 sequence:1 union:5 wfc:1` | field, map, markov, path, wfc |
| TODO | `Island` | 0 | `sequence` | `all:23 convolution:8 field:1 observe:4 one:14 prl:16 rule:43 sequence:3` | convolution, field, observe |
| TODO | `Backtracker` | 0 | `markov` | `markov:1 one:2` | markov |
| TODO | `BacktrackerCycle` | 0 | `sequence` | `all:2 markov:1 one:4 sequence:1 union:1` | markov |
| PASS | `Basic` | 0 | `one` | `one:1` | full |
| TODO | `BasicBrickWall` | 0 | `sequence` | `all:5 markov:2 one:4 sequence:1` | markov |
| TODO | `BasicDijkstraDungeon` | 0 | `sequence` | `all:2 markov:1 one:2 path:1 sequence:1` | markov, path |
| TODO | `BasicDijkstraFill` | 0 | `sequence` | `all:2 markov:1 one:1 path:1 sequence:1` | markov, path |
| PASS | `BasicDungeonGrowth` | 0 | `sequence` | `all:4 one:2 rule:2 sequence:1 union:1` | full |
| TODO | `BasicPartitioning` | 0 | `sequence` | `all:1 markov:1 one:2 sequence:1` | markov |
| TODO | `BernoulliPercolation` | 0 | `sequence` | `all:1 path:1 prl:4 sequence:1` | path |
| TODO | `BiasedGrowth` | 0 | `sequence` | `field:1 one:1 prl:2 rule:1 sequence:1` | field |
| TODO | `BiasedGrowthContraction` | 0 | `sequence` | `field:2 one:2 prl:2 rule:2 sequence:1` | field |
| TODO | `BiasedMazeGrowth` | 0 | `sequence` | `field:1 one:1 prl:2 rule:1 sequence:1` | field |
| TODO | `BiasedVoronoi` | 0 | `sequence` | `field:2 one:3 rule:2 sequence:1` | field |
| TODO | `BishopParity` | 0 | `sequence` | `field:2 observe:4 one:4 rule:3 sequence:1` | field, observe |
| TODO | `BlueNoise` | 0 | `one` | `field:1 one:1 rule:1` | field |
| TODO | `Cave` | 0 | `sequence` | `all:1 convolution:1 prl:2 rule:2 sequence:1` | convolution |
| TODO | `CaveContour` | 0 | `sequence` | `all:3 convolution:1 prl:4 rule:8 sequence:1` | convolution |
| TODO | `CentralCrawlers` | 0 | `sequence` | `all:1 field:1 one:1 rule:3 sequence:1` | field |
| TODO | `CentralSAW` | 0 | `one` | `field:1 one:1` | field |
| TODO | `ChainDungeon` | 0 | `sequence` | `all:5 convchain:1 markov:1 one:2 path:1 sequence:1` | convchain, markov, path |
| TODO | `ChainDungeonMaze` | 0 | `sequence` | `all:4 convchain:1 markov:1 one:2 path:1 sequence:1` | convchain, markov, path |
| TODO | `ChainMaze` | 0 | `sequence` | `all:1 convchain:1 sequence:1` | convchain |
| TODO | `Circuit` | 0 | `sequence` | `all:6 markov:2 one:4 path:1 prl:2 rule:12 sequence:1` | markov, path |
| TODO | `ClosedSurface` | 0 | `sequence` | `all:2 rule:1 sequence:1 wfc:1` | wfc |
| TODO | `ColoredKnots` | 0 | `sequence` | `all:3 markov:1 one:1 rule:30 sequence:1 wfc:1` | markov, wfc |
| TODO | `CompleteSAW` | 0 | `sequence` | `all:1 observe:3 one:1 rule:2 sequence:1` | observe |
| TODO | `CompleteSAWSmart` | 0 | `sequence` | `all:2 observe:5 one:3 rule:6 sequence:1` | observe |
| TODO | `ConnectedCaves` | 0 | `sequence` | `all:1 convolution:1 markov:1 one:1 path:1 prl:2 rule:2 sequence:1` | convolution, markov, path |
| TODO | `ConstrainedCaves` | 0 | `sequence` | `all:1 convolution:1 markov:1 one:2 path:1 prl:3 rule:2 sequence:1` | convolution, markov, path |
| TODO | `Counting` | 0 | `convolution` | `convolution:1 rule:4` | convolution |
| TODO | `Coupling` | 0 | `sequence` | `all:1 field:2 one:2 rule:4 sequence:1` | field |
| TODO | `CrawlersChase` | 0 | `sequence` | `all:1 field:2 markov:1 one:2 rule:6 sequence:1` | field, markov |
| TODO | `CrossCountry` | 0 | `sequence` | `all:1 convolution:1 field:2 observe:4 one:3 prl:2 rule:7 sequence:1` | convolution, field, observe |
| PASS | `Cycles` | 0 | `sequence` | `all:2 one:2 sequence:1` | full |
| TODO | `DenseSAW` | 0 | `sequence` | `field:1 one:2 sequence:1` | field |
| TODO | `DiagonalPath` | 0 | `sequence` | `field:1 observe:3 one:3 rule:2 sequence:1` | field, observe |
| TODO | `Digger` | 0 | `markov` | `markov:1 one:2` | markov |
| TODO | `DijkstraDungeon` | 0 | `sequence` | `all:4 markov:1 one:3 path:1 rule:2 sequence:1 union:1` | markov, path |
| TODO | `Division` | 0 | `sequence` | `all:3 field:10 prl:4 rule:10 sequence:1` | field |
| LIKELY | `DualRetraction` | 0 | `sequence` | `all:3 one:1 rule:6 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `DualRetraction3D` | 0 | `sequence` | `all:2 one:1 rule:8 sequence:1` | root node subset implemented; needs compare |
| TODO | `DungeonGrowth` | 0 | `sequence` | `all:5 markov:1 one:4 path:1 prl:1 rule:27 sequence:1 union:1` | markov, path |
| TODO | `Dwarves` | 0 | `sequence` | `all:1 field:2 one:3 rule:6 sequence:1` | field |
| TODO | `Escher` | 0 | `sequence` | `all:3 rule:3 sequence:1 wfc:1` | wfc |
| TODO | `EscherSurface` | 0 | `sequence` | `all:3 rule:4 sequence:1 wfc:1` | wfc |
| TODO | `EuclideanPath` | 0 | `sequence` | `all:1 field:2 observe:3 one:5 rule:7 sequence:1` | field, observe |
| TODO | `FindLongCycle` | 0 | `sequence` | `all:3 markov:3 one:5 prl:1 rule:9 sequence:2 union:1` | markov |
| TODO | `FireNoise` | 0 | `sequence` | `all:8 markov:2 one:2 prl:2 rule:13 sequence:3` | markov |
| TODO | `Flowers` | 0 | `sequence` | `all:3 markov:1 one:2 rule:4 sequence:1` | markov |
| TODO | `Forest` | 0 | `sequence` | `all:4 markov:1 one:3 prl:1 rule:2 sequence:1` | markov |
| PASS | `ForestFire` | 0 | `prl` | `prl:1 rule:5` | steps=10 |
| TODO | `ForestFireCA` | 0 | `convolution` | `convolution:1 rule:4` | convolution |
| TODO | `GameOfLife` | 0 | `sequence` | `convolution:1 prl:1 rule:2 sequence:1` | convolution |
| PASS | `Growth` | 0 | `one` | `one:1` | steps=100 |
| PASS | `Growth` | 1 | `one` | `one:1` | full |
| LIKELY | `GrowthCompetition` | 0 | `sequence` | `one:3 rule:4 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `GrowthContraction` | 0 | `one` | `one:1 rule:2` | root node subset implemented; needs compare |
| LIKELY | `GrowthWalk` | 0 | `one` | `one:1 rule:2` | root node subset implemented; needs compare |
| TODO | `GrowTo` | 0 | `sequence` | `field:1 one:3 sequence:1` | field |
| TODO | `HamiltonianPath` | 0 | `sequence` | `all:1 markov:2 one:7 rule:2 sequence:2` | markov |
| TODO | `HamiltonianPaths` | 0 | `sequence` | `all:2 markov:1 one:3 sequence:1` | markov |
| TODO | `Hills` | 0 | `sequence` | `convolution:1 one:1 prl:2 rule:2 sequence:1` | convolution |
| LIKELY | `IrregularMazeGrowth` | 0 | `one` | `one:1` | root node subset implemented; needs compare |
| PASS | `IrregularSAW` | 0 | `one` | `one:1` | steps=100 |
| TODO | `Keys` | 0 | `sequence` | `field:2 markov:1 one:6 prl:2 rule:6 sequence:1` | field, markov |
| TODO | `Keys` | 1 | `sequence` | `field:2 markov:1 one:6 prl:2 rule:6 sequence:1` | field, markov |
| TODO | `KnightPatrol` | 0 | `markov` | `markov:1 observe:3 one:2 prl:1` | markov, observe |
| TODO | `Knots2D` | 0 | `sequence` | `all:1 rule:2 sequence:1 wfc:1` | wfc |
| TODO | `Knots3D` | 0 | `sequence` | `all:2 rule:1 sequence:1 wfc:1` | wfc |
| TODO | `Laplace` | 0 | `one` | `field:1 one:1 rule:1` | field |
| LIKELY | `LoopGrowth` | 0 | `sequence` | `all:1 one:2 sequence:1` | root node subset implemented; needs compare |
| TODO | `LostCity` | 0 | `sequence` | `all:5 convolution:2 markov:1 one:5 prl:3 rule:9 sequence:1` | convolution, markov |
| TODO | `MarchingSquares` | 0 | `sequence` | `map:1 prl:1 rule:6 sequence:1` | map |
| TODO | `MazeBacktracker` | 0 | `markov` | `markov:1 one:2` | markov |
| TODO | `MazeBacktracker` | 1 | `markov` | `markov:1 one:2` | markov |
| LIKELY | `MazeGrowth` | 0 | `one` | `one:1` | root node subset implemented; needs compare |
| LIKELY | `MazeGrowth` | 1 | `one` | `one:1` | root node subset implemented; needs compare |
| TODO | `MazeMap` | 0 | `sequence` | `all:1 map:1 rule:8 sequence:1` | map |
| LIKELY | `MazeTrail` | 0 | `one` | `one:1 rule:2` | root node subset implemented; needs compare |
| LIKELY | `MazeTrail` | 1 | `one` | `one:1 rule:2` | root node subset implemented; needs compare |
| TODO | `MultiHeadedDungeon` | 0 | `sequence` | `all:10 markov:1 one:1 prl:1 sequence:2` | markov |
| LIKELY | `MultiHeadedWalk` | 0 | `sequence` | `all:2 one:1 sequence:2` | root node subset implemented; needs compare |
| TODO | `MultiHeadedWalkDungeon` | 0 | `sequence` | `all:7 markov:1 one:1 sequence:2` | markov |
| LIKELY | `NestedGrowth` | 0 | `all` | `all:1 rule:10` | root node subset implemented; needs compare |
| TODO | `NoDeadEnds` | 0 | `markov` | `all:2 markov:1 one:2` | markov |
| TODO | `NoDeadEnds` | 1 | `markov` | `all:2 markov:1 one:2` | markov |
| PASS | `Noise` | 0 | `sequence` | `one:1 prl:2 rule:2 sequence:1` | full |
| LIKELY | `Noise` | 1 | `sequence` | `one:1 prl:2 rule:2 sequence:1` | root node subset implemented; needs compare |
| TODO | `NystromDungeon` | 0 | `sequence` | `all:5 markov:2 one:7 sequence:1` | markov |
| TODO | `OddScale` | 0 | `sequence` | `map:1 prl:2 rule:1 sequence:1` | map |
| TODO | `OddScale3D` | 0 | `sequence` | `all:3 map:1 markov:1 one:2 prl:2 rule:3 sequence:2` | map, markov |
| TODO | `OpenCave` | 0 | `sequence` | `convolution:1 prl:2 rule:2 sequence:1` | convolution |
| TODO | `OpenCave3D` | 0 | `sequence` | `convolution:1 prl:2 rule:2 sequence:1` | convolution |
| TODO | `OrganicMechanic` | 0 | `sequence` | `all:1 field:3 one:1 rule:10 sequence:1` | field |
| TODO | `OrientedEscher` | 0 | `sequence` | `all:1 prl:2 rule:4 sequence:1 wfc:1` | wfc |
| TODO | `PaintCompetition` | 0 | `sequence` | `all:2 field:2 one:2 rule:6 sequence:1` | field |
| LIKELY | `ParallelGrowth` | 0 | `all` | `all:1` | root node subset implemented; needs compare |
| PASS | `ParallelMazeGrowth` | 0 | `all` | `all:1` | full |
| TODO | `Partitioning` | 0 | `sequence` | `all:3 rule:1 sequence:2 wfc:1` | wfc |
| TODO | `Percolation` | 0 | `sequence` | `path:1 prl:3 sequence:1` | path |
| TODO | `PeriodicEscher` | 0 | `sequence` | `all:4 rule:9 sequence:2 wfc:1` | wfc |
| TODO | `PillarsOfEternity` | 0 | `sequence` | `all:8 rule:13 sequence:1 wfc:1` | wfc |
| LIKELY | `Push` | 0 | `sequence` | `all:1 one:2 rule:2 sequence:1` | root node subset implemented; needs compare |
| TODO | `PutColoredLs` | 0 | `markov` | `all:1 markov:1 one:2 rule:6` | markov |
| PASS | `PutLs` | 0 | `all` | `all:1` | steps=5 |
| LIKELY | `RainbowGrowth` | 0 | `one` | `one:1 rule:7` | root node subset implemented; needs compare |
| TODO | `RegularPath` | 0 | `sequence` | `all:2 markov:1 observe:3 one:4 prl:1 sequence:1` | markov, observe |
| LIKELY | `RegularSAW` | 0 | `one` | `one:1` | root node subset implemented; needs compare |
| LIKELY | `RegularSAW` | 1 | `one` | `one:1` | root node subset implemented; needs compare |
| TODO | `RegularSAWRestart` | 0 | `markov` | `markov:1 one:2` | markov |
| TODO | `RegularSAWRestart` | 1 | `markov` | `markov:1 one:2` | markov |
| LIKELY | `River` | 0 | `sequence` | `all:5 one:5 rule:6 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `River` | 1 | `sequence` | `all:5 one:5 rule:6 sequence:1` | root node subset implemented; needs compare |
| TODO | `Rosettes` | 0 | `sequence` | `all:8 convolution:1 field:6 markov:1 prl:3 rule:16 sequence:1` | convolution, field, markov |
| TODO | `SAWRestart` | 0 | `markov` | `markov:1 one:2` | markov |
| TODO | `SelectLargeCaves` | 0 | `sequence` | `all:3 convolution:1 markov:1 one:2 prl:2 rule:4 sequence:2` | convolution, markov |
| TODO | `SelectLongKnots` | 0 | `sequence` | `all:2 markov:1 one:1 prl:2 rule:5 sequence:2 wfc:1` | markov, wfc |
| PASS | `SelfAvoidingWalk` | 0 | `one` | `one:1` | steps=100 |
| TODO | `Sewers` | 0 | `sequence` | `all:1 markov:1 one:2 path:2 rule:1 sequence:1 wfc:1` | markov, path, wfc |
| TODO | `SmarterDigger` | 0 | `markov` | `markov:1 one:1 path:1` | markov, path |
| TODO | `SmartSAW` | 0 | `sequence` | `all:3 markov:4 one:5 prl:1 rule:5 sequence:2 union:2` | markov |
| LIKELY | `SmoothTrail` | 0 | `sequence` | `all:1 one:2 rule:4 sequence:1` | root node subset implemented; needs compare |
| TODO | `SnellLaw` | 0 | `sequence` | `all:3 observe:4 one:2 prl:2 rule:7 sequence:1` | observe |
| TODO | `SoftPath` | 0 | `sequence` | `all:1 field:3 one:3 prl:1 rule:7 sequence:1` | field |
| TODO | `SoftPath` | 1 | `sequence` | `all:1 field:3 one:3 prl:1 rule:7 sequence:1` | field |
| TODO | `StairsPath` | 0 | `sequence` | `all:1 map:1 observe:5 one:4 prl:1 rule:9 sequence:1` | map, observe |
| LIKELY | `StochasticVoronoi` | 0 | `sequence` | `one:3 rule:2 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `StochasticVoronoi` | 1 | `sequence` | `one:3 rule:2 sequence:1` | root node subset implemented; needs compare |
| TODO | `StormySnellLaw` | 0 | `sequence` | `all:3 observe:4 one:5 prl:3 rule:9 sequence:1` | observe |
| TODO | `StrangeNoise` | 0 | `sequence` | `field:1 one:2 rule:1 sequence:1` | field |
| LIKELY | `StrangeDungeon` | 0 | `sequence` | `all:3 one:1 prl:3 rule:3 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `StrangeDungeon` | 1 | `sequence` | `all:3 one:1 prl:3 rule:3 sequence:1` | root node subset implemented; needs compare |
| PASS | `StrangeGrowth` | 0 | `one` | `one:1` | steps=100 |
| TODO | `SubmergedKnots` | 0 | `sequence` | `all:4 one:1 rule:1 sequence:2 wfc:1` | wfc |
| TODO | `Surface` | 0 | `sequence` | `sequence:1 wfc:1` | wfc |
| TODO | `Tetris` | 0 | `sequence` | `all:2 markov:1 one:5 prl:4 rule:9 sequence:1 union:1` | markov |
| TODO | `Texture` | 0 | `sequence` | `all:3 markov:1 one:2 rule:4 sequence:1` | markov |
| TODO | `TileDungeon` | 0 | `sequence` | `all:2 markov:1 one:1 path:1 rule:1 sequence:1 wfc:1` | markov, path, wfc |
| TODO | `TilePath` | 0 | `sequence` | `all:2 one:4 rule:3 sequence:1 wfc:1` | wfc |
| PASS | `Trail` | 0 | `one` | `one:1 rule:2` | steps=100 |
| LIKELY | `Voronoi` | 0 | `sequence` | `all:1 one:2 rule:2 sequence:1` | root node subset implemented; needs compare |
| LIKELY | `Voronoi` | 1 | `sequence` | `all:1 one:2 rule:2 sequence:1` | root node subset implemented; needs compare |
| TODO | `WaveBrickWall` | 0 | `sequence` | `rule:1 sequence:1 wfc:1` | wfc |
| TODO | `WaveDungeon` | 0 | `sequence` | `all:5 markov:1 one:3 path:1 rule:2 sequence:1 wfc:1` | markov, path, wfc |
| TODO | `WaveFlowers` | 0 | `sequence` | `all:1 rule:2 sequence:1 wfc:1` | wfc |
| TODO | `WolfBasedApproach` | 0 | `sequence` | `all:3 field:2 one:2 prl:2 rule:12 sequence:1` | field |
