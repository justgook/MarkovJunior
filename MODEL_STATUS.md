# Model Port Status

Tracks `models/*.xml` coverage for the Odin port.

## Summary

- `models.xml` entries with files: 155
- unique model XML files: 137
- passing/recorded: 139
- likely supported but unverified: 0
- TODO / unsupported: 16

## Legend

- `PASS`: compared successfully with C# for the note shown.
- `LIKELY`: root/tag subset exists in Odin, but compare has not been recorded.
- `TODO`: requires unsupported node types or features.

## Entries

| Status | Model | model-index | Root | Tags | Note |
|---|---:|---:|---|---|---|
| TODO | `Apartemazements` | 0 | `sequence` | `all:6 prl:16 rule:28 sequence:1 wfc:1` | tile-based WFC not ported yet |
| TODO | `Apartemazements` | 1 | `sequence` | `all:6 prl:16 rule:28 sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `CarmaTower` | 0 | `sequence` | `all:68 convolution:2 map:1 markov:12 one:41 path:5 prl:33 rule:178 sequence:2 union:11` | steps=200 |
| PASS | `CarmaTower` | 1 | `sequence` | `all:68 convolution:2 map:1 markov:12 one:41 path:5 prl:33 rule:178 sequence:2 union:11` | steps=200 |
| TODO | `ModernHouse` | 0 | `sequence` | `all:29 map:2 markov:8 one:27 path:4 prl:100 rule:352 sequence:1 union:18 wfc:2` | tile-based WFC not ported yet |
| TODO | `ModernHouse` | 1 | `sequence` | `all:29 map:2 markov:8 one:27 path:4 prl:100 rule:352 sequence:1 union:18 wfc:2` | tile-based WFC not ported yet |
| TODO | `SeaVilla` | 0 | `sequence` | `all:27 field:2 map:1 markov:8 one:29 path:7 prl:41 rule:236 sequence:1 union:5 wfc:1` | tile-based WFC not ported yet |
| TODO | `SeaVilla` | 1 | `sequence` | `all:27 field:2 map:1 markov:8 one:29 path:7 prl:41 rule:236 sequence:1 union:5 wfc:1` | tile-based WFC not ported yet |
| PASS | `Island` | 0 | `sequence` | `all:23 convolution:8 field:1 observe:4 one:14 prl:16 rule:43 sequence:3` | steps=200 |
| PASS | `Backtracker` | 0 | `markov` | `markov:1 one:2` | full |
| PASS | `BacktrackerCycle` | 0 | `sequence` | `all:2 markov:1 one:4 sequence:1 union:1` | full |
| PASS | `Basic` | 0 | `one` | `one:1` | full |
| PASS | `BasicBrickWall` | 0 | `sequence` | `all:5 markov:2 one:4 sequence:1` | full |
| PASS | `BasicDijkstraDungeon` | 0 | `sequence` | `all:2 markov:1 one:2 path:1 sequence:1` | steps=500 |
| PASS | `BasicDijkstraFill` | 0 | `sequence` | `all:2 markov:1 one:1 path:1 sequence:1` | steps=500 |
| PASS | `BasicDungeonGrowth` | 0 | `sequence` | `all:4 one:2 rule:2 sequence:1 union:1` | full |
| PASS | `BasicPartitioning` | 0 | `sequence` | `all:1 markov:1 one:2 sequence:1` | full |
| PASS | `BernoulliPercolation` | 0 | `sequence` | `all:1 path:1 prl:4 sequence:1` | steps=500 |
| PASS | `BiasedGrowth` | 0 | `sequence` | `field:1 one:1 prl:2 rule:1 sequence:1` | steps=200 |
| PASS | `BiasedGrowthContraction` | 0 | `sequence` | `field:2 one:2 prl:2 rule:2 sequence:1` | steps=200 |
| PASS | `BiasedMazeGrowth` | 0 | `sequence` | `field:1 one:1 prl:2 rule:1 sequence:1` | steps=200 |
| PASS | `BiasedVoronoi` | 0 | `sequence` | `field:2 one:3 rule:2 sequence:1` | steps=200 |
| PASS | `BishopParity` | 0 | `sequence` | `field:2 observe:4 one:4 rule:3 sequence:1` | steps=200 |
| PASS | `BlueNoise` | 0 | `one` | `field:1 one:1 rule:1` | steps=200 |
| PASS | `Cave` | 0 | `sequence` | `all:1 convolution:1 prl:2 rule:2 sequence:1` | steps=100 |
| PASS | `CaveContour` | 0 | `sequence` | `all:3 convolution:1 prl:4 rule:8 sequence:1` | steps=100 |
| PASS | `CentralCrawlers` | 0 | `sequence` | `all:1 field:1 one:1 rule:3 sequence:1` | steps=200 |
| PASS | `CentralSAW` | 0 | `one` | `field:1 one:1` | steps=200 |
| PASS | `ChainDungeon` | 0 | `sequence` | `all:5 convchain:1 markov:1 one:2 path:1 sequence:1` | steps=200 |
| PASS | `ChainDungeonMaze` | 0 | `sequence` | `all:4 convchain:1 markov:1 one:2 path:1 sequence:1` | steps=200 |
| PASS | `ChainMaze` | 0 | `sequence` | `all:1 convchain:1 sequence:1` | steps=200 |
| PASS | `Circuit` | 0 | `sequence` | `all:6 markov:2 one:4 path:1 prl:2 rule:12 sequence:1` | steps=500 |
| TODO | `ClosedSurface` | 0 | `sequence` | `all:2 rule:1 sequence:1 wfc:1` | tile-based WFC not ported yet |
| TODO | `ColoredKnots` | 0 | `sequence` | `all:3 markov:1 one:1 rule:30 sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `CompleteSAW` | 0 | `sequence` | `all:1 observe:3 one:1 rule:2 sequence:1` | steps=500 |
| PASS | `CompleteSAWSmart` | 0 | `sequence` | `all:2 observe:5 one:3 rule:6 sequence:1` | steps=500 |
| PASS | `ConnectedCaves` | 0 | `sequence` | `all:1 convolution:1 markov:1 one:1 path:1 prl:2 rule:2 sequence:1` | steps=100 |
| PASS | `ConstrainedCaves` | 0 | `sequence` | `all:1 convolution:1 markov:1 one:2 path:1 prl:3 rule:2 sequence:1` | steps=100 |
| PASS | `Counting` | 0 | `convolution` | `convolution:1 rule:4` | steps=100 |
| PASS | `Coupling` | 0 | `sequence` | `all:1 field:2 one:2 rule:4 sequence:1` | steps=200 |
| PASS | `CrawlersChase` | 0 | `sequence` | `all:1 field:2 markov:1 one:2 rule:6 sequence:1` | steps=200 |
| PASS | `CrossCountry` | 0 | `sequence` | `all:1 convolution:1 field:2 observe:4 one:3 prl:2 rule:7 sequence:1` | steps=200 |
| PASS | `Cycles` | 0 | `sequence` | `all:2 one:2 sequence:1` | full |
| PASS | `DenseSAW` | 0 | `sequence` | `field:1 one:2 sequence:1` | steps=200 |
| PASS | `DiagonalPath` | 0 | `sequence` | `field:1 observe:3 one:3 rule:2 sequence:1` | steps=200 |
| PASS | `Digger` | 0 | `markov` | `markov:1 one:2` | steps=100 |
| PASS | `DijkstraDungeon` | 0 | `sequence` | `all:4 markov:1 one:3 path:1 rule:2 sequence:1 union:1` | steps=200 |
| PASS | `Division` | 0 | `sequence` | `all:3 field:10 prl:4 rule:10 sequence:1` | steps=200 |
| PASS | `DualRetraction` | 0 | `sequence` | `all:3 one:1 rule:6 sequence:1` | steps=500 |
| PASS | `DualRetraction3D` | 0 | `sequence` | `all:2 one:1 rule:8 sequence:1` | steps=500 |
| PASS | `DungeonGrowth` | 0 | `sequence` | `all:5 markov:1 one:4 path:1 prl:1 rule:27 sequence:1 union:1` | steps=200 |
| PASS | `Dwarves` | 0 | `sequence` | `all:1 field:2 one:3 rule:6 sequence:1` | steps=200 |
| TODO | `Escher` | 0 | `sequence` | `all:3 rule:3 sequence:1 wfc:1` | tile-based WFC not ported yet |
| TODO | `EscherSurface` | 0 | `sequence` | `all:3 rule:4 sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `EuclideanPath` | 0 | `sequence` | `all:1 field:2 observe:3 one:5 rule:7 sequence:1` | steps=200 |
| PASS | `FindLongCycle` | 0 | `sequence` | `all:3 markov:3 one:5 prl:1 rule:9 sequence:2 union:1` | steps=200 |
| PASS | `FireNoise` | 0 | `sequence` | `all:8 markov:2 one:2 prl:2 rule:13 sequence:3` | steps=200 |
| PASS | `Flowers` | 0 | `sequence` | `all:3 markov:1 one:2 rule:4 sequence:1` | steps=200 |
| PASS | `Forest` | 0 | `sequence` | `all:4 markov:1 one:3 prl:1 rule:2 sequence:1` | full |
| PASS | `ForestFire` | 0 | `prl` | `prl:1 rule:5` | steps=10 |
| PASS | `ForestFireCA` | 0 | `convolution` | `convolution:1 rule:4` | steps=200 |
| PASS | `GameOfLife` | 0 | `sequence` | `convolution:1 prl:1 rule:2 sequence:1` | steps=100 |
| PASS | `Growth` | 0 | `one` | `one:1` | steps=100 |
| PASS | `Growth` | 1 | `one` | `one:1` | full |
| PASS | `GrowthCompetition` | 0 | `sequence` | `one:3 rule:4 sequence:1` | steps=200 |
| PASS | `GrowthContraction` | 0 | `one` | `one:1 rule:2` | steps=500 |
| PASS | `GrowthWalk` | 0 | `one` | `one:1 rule:2` | steps=500 |
| PASS | `GrowTo` | 0 | `sequence` | `field:1 one:3 sequence:1` | steps=200 |
| PASS | `HamiltonianPath` | 0 | `sequence` | `all:1 markov:2 one:7 rule:2 sequence:2` | steps=200 |
| PASS | `HamiltonianPaths` | 0 | `sequence` | `all:2 markov:1 one:3 sequence:1` | steps=200 |
| PASS | `Hills` | 0 | `sequence` | `convolution:1 one:1 prl:2 rule:2 sequence:1` | steps=100 |
| PASS | `IrregularMazeGrowth` | 0 | `one` | `one:1` | steps=500 |
| PASS | `IrregularSAW` | 0 | `one` | `one:1` | steps=100 |
| PASS | `Keys` | 0 | `sequence` | `field:2 markov:1 one:6 prl:2 rule:6 sequence:1` | steps=200 |
| PASS | `Keys` | 1 | `sequence` | `field:2 markov:1 one:6 prl:2 rule:6 sequence:1` | steps=200 |
| PASS | `KnightPatrol` | 0 | `markov` | `markov:1 observe:3 one:2 prl:1` | steps=200 |
| PASS | `Knots2D` | 0 | `sequence` | `all:1 rule:2 sequence:1 wfc:1` | steps=500 |
| TODO | `Knots3D` | 0 | `sequence` | `all:2 rule:1 sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `Laplace` | 0 | `one` | `field:1 one:1 rule:1` | steps=200 |
| PASS | `LoopGrowth` | 0 | `sequence` | `all:1 one:2 sequence:1` | steps=200 |
| PASS | `LostCity` | 0 | `sequence` | `all:5 convolution:2 markov:1 one:5 prl:3 rule:9 sequence:1` | steps=200 |
| PASS | `MarchingSquares` | 0 | `sequence` | `map:1 prl:1 rule:6 sequence:1` | steps=200 |
| PASS | `MazeBacktracker` | 0 | `markov` | `markov:1 one:2` | steps=100 |
| PASS | `MazeBacktracker` | 1 | `markov` | `markov:1 one:2` | steps=500 |
| PASS | `MazeGrowth` | 0 | `one` | `one:1` | steps=500 |
| PASS | `MazeGrowth` | 1 | `one` | `one:1` | steps=500 |
| PASS | `MazeMap` | 0 | `sequence` | `all:1 map:1 rule:8 sequence:1` | steps=200 |
| PASS | `MazeTrail` | 0 | `one` | `one:1 rule:2` | steps=500 |
| PASS | `MazeTrail` | 1 | `one` | `one:1 rule:2` | steps=500 |
| PASS | `MultiHeadedDungeon` | 0 | `sequence` | `all:10 markov:1 one:1 prl:1 sequence:2` | steps=200 |
| PASS | `MultiHeadedWalk` | 0 | `sequence` | `all:2 one:1 sequence:2` | steps=200 |
| PASS | `MultiHeadedWalkDungeon` | 0 | `sequence` | `all:7 markov:1 one:1 sequence:2` | steps=200 |
| PASS | `NestedGrowth` | 0 | `all` | `all:1 rule:10` | steps=500 |
| PASS | `NoDeadEnds` | 0 | `markov` | `all:2 markov:1 one:2` | full |
| PASS | `NoDeadEnds` | 1 | `markov` | `all:2 markov:1 one:2` | steps=100 |
| PASS | `Noise` | 0 | `sequence` | `one:1 prl:2 rule:2 sequence:1` | full |
| PASS | `Noise` | 1 | `sequence` | `one:1 prl:2 rule:2 sequence:1` | steps=500 |
| PASS | `NystromDungeon` | 0 | `sequence` | `all:5 markov:2 one:7 sequence:1` | steps=200 |
| PASS | `OddScale` | 0 | `sequence` | `map:1 prl:2 rule:1 sequence:1` | steps=200 |
| PASS | `OddScale3D` | 0 | `sequence` | `all:3 map:1 markov:1 one:2 prl:2 rule:3 sequence:2` | steps=200 |
| PASS | `OpenCave` | 0 | `sequence` | `convolution:1 prl:2 rule:2 sequence:1` | steps=100 |
| PASS | `OpenCave3D` | 0 | `sequence` | `convolution:1 prl:2 rule:2 sequence:1` | steps=100 |
| PASS | `OrganicMechanic` | 0 | `sequence` | `all:1 field:3 one:1 rule:10 sequence:1` | steps=200 |
| TODO | `OrientedEscher` | 0 | `sequence` | `all:1 prl:2 rule:4 sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `PaintCompetition` | 0 | `sequence` | `all:2 field:2 one:2 rule:6 sequence:1` | steps=200 |
| PASS | `ParallelGrowth` | 0 | `all` | `all:1` | steps=500 |
| PASS | `ParallelMazeGrowth` | 0 | `all` | `all:1` | full |
| PASS | `Partitioning` | 0 | `sequence` | `all:3 rule:1 sequence:2 wfc:1` | steps=500 |
| PASS | `Percolation` | 0 | `sequence` | `path:1 prl:3 sequence:1` | steps=500 |
| TODO | `PeriodicEscher` | 0 | `sequence` | `all:4 rule:9 sequence:2 wfc:1` | tile-based WFC not ported yet |
| PASS | `PillarsOfEternity` | 0 | `sequence` | `all:8 rule:13 sequence:1 wfc:1` | steps=500 |
| PASS | `Push` | 0 | `sequence` | `all:1 one:2 rule:2 sequence:1` | steps=500 |
| PASS | `PutColoredLs` | 0 | `markov` | `all:1 markov:1 one:2 rule:6` | full |
| PASS | `PutLs` | 0 | `all` | `all:1` | steps=5 |
| PASS | `RainbowGrowth` | 0 | `one` | `one:1 rule:7` | steps=500 |
| PASS | `RegularPath` | 0 | `sequence` | `all:2 markov:1 observe:3 one:4 prl:1 sequence:1` | steps=200 |
| PASS | `RegularSAW` | 0 | `one` | `one:1` | steps=500 |
| PASS | `RegularSAW` | 1 | `one` | `one:1` | steps=500 |
| PASS | `RegularSAWRestart` | 0 | `markov` | `markov:1 one:2` | steps=100 |
| PASS | `RegularSAWRestart` | 1 | `markov` | `markov:1 one:2` | steps=500 |
| PASS | `River` | 0 | `sequence` | `all:5 one:5 rule:6 sequence:1` | steps=200 |
| PASS | `River` | 1 | `sequence` | `all:5 one:5 rule:6 sequence:1` | steps=500 |
| PASS | `Rosettes` | 0 | `sequence` | `all:8 convolution:1 field:6 markov:1 prl:3 rule:16 sequence:1` | steps=200 |
| PASS | `SAWRestart` | 0 | `markov` | `markov:1 one:2` | steps=100 |
| PASS | `SelectLargeCaves` | 0 | `sequence` | `all:3 convolution:1 markov:1 one:2 prl:2 rule:4 sequence:2` | steps=200 |
| TODO | `SelectLongKnots` | 0 | `sequence` | `all:2 markov:1 one:1 prl:2 rule:5 sequence:2 wfc:1` | tile-based WFC not ported yet |
| PASS | `SelfAvoidingWalk` | 0 | `one` | `one:1` | steps=100 |
| PASS | `Sewers` | 0 | `sequence` | `all:1 markov:1 one:2 path:2 rule:1 sequence:1 wfc:1` | steps=500 |
| PASS | `SmarterDigger` | 0 | `markov` | `markov:1 one:1 path:1` | steps=500 |
| PASS | `SmartSAW` | 0 | `sequence` | `all:3 markov:4 one:5 prl:1 rule:5 sequence:2 union:2` | steps=200 |
| PASS | `SmoothTrail` | 0 | `sequence` | `all:1 one:2 rule:4 sequence:1` | steps=200 |
| PASS | `SnellLaw` | 0 | `sequence` | `all:3 observe:4 one:2 prl:2 rule:7 sequence:1` | steps=200 |
| PASS | `SoftPath` | 0 | `sequence` | `all:1 field:3 one:3 prl:1 rule:7 sequence:1` | steps=200 |
| PASS | `SoftPath` | 1 | `sequence` | `all:1 field:3 one:3 prl:1 rule:7 sequence:1` | steps=200 |
| PASS | `StairsPath` | 0 | `sequence` | `all:1 map:1 observe:5 one:4 prl:1 rule:9 sequence:1` | steps=200 |
| PASS | `StochasticVoronoi` | 0 | `sequence` | `one:3 rule:2 sequence:1` | steps=200 |
| PASS | `StochasticVoronoi` | 1 | `sequence` | `one:3 rule:2 sequence:1` | steps=500 |
| PASS | `StormySnellLaw` | 0 | `sequence` | `all:3 observe:4 one:5 prl:3 rule:9 sequence:1` | steps=200 |
| PASS | `StrangeNoise` | 0 | `sequence` | `field:1 one:2 rule:1 sequence:1` | steps=200 |
| PASS | `StrangeDungeon` | 0 | `sequence` | `all:3 one:1 prl:3 rule:3 sequence:1` | steps=200 |
| PASS | `StrangeDungeon` | 1 | `sequence` | `all:3 one:1 prl:3 rule:3 sequence:1` | steps=500 |
| PASS | `StrangeGrowth` | 0 | `one` | `one:1` | steps=100 |
| TODO | `SubmergedKnots` | 0 | `sequence` | `all:4 one:1 rule:1 sequence:2 wfc:1` | tile-based WFC not ported yet |
| TODO | `Surface` | 0 | `sequence` | `sequence:1 wfc:1` | tile-based WFC not ported yet |
| PASS | `Tetris` | 0 | `sequence` | `all:2 markov:1 one:5 prl:4 rule:9 sequence:1 union:1` | steps=200 |
| PASS | `Texture` | 0 | `sequence` | `all:3 markov:1 one:2 rule:4 sequence:1` | steps=200 |
| PASS | `TileDungeon` | 0 | `sequence` | `all:2 markov:1 one:1 path:1 rule:1 sequence:1 wfc:1` | steps=500 |
| PASS | `TilePath` | 0 | `sequence` | `all:2 one:4 rule:3 sequence:1 wfc:1` | steps=500 |
| PASS | `Trail` | 0 | `one` | `one:1 rule:2` | steps=100 |
| PASS | `Voronoi` | 0 | `sequence` | `all:1 one:2 rule:2 sequence:1` | steps=200 |
| PASS | `Voronoi` | 1 | `sequence` | `all:1 one:2 rule:2 sequence:1` | steps=500 |
| PASS | `WaveBrickWall` | 0 | `sequence` | `rule:1 sequence:1 wfc:1` | steps=500 |
| PASS | `WaveDungeon` | 0 | `sequence` | `all:5 markov:1 one:3 path:1 rule:2 sequence:1 wfc:1` | steps=500 |
| PASS | `WaveFlowers` | 0 | `sequence` | `all:1 rule:2 sequence:1 wfc:1` | steps=500 |
| PASS | `WolfBasedApproach` | 0 | `sequence` | `all:3 field:2 one:2 prl:2 rule:12 sequence:1` | steps=200 |
