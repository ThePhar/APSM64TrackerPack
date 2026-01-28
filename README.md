# Phar's SM64 Archipelago PopTracker Pack

This is a [PopTracker](https://github.com/black-sliver/PopTracker) pack for the **Archipelago Super Mario 64 Randomizer**.

![Example 1 of SM64 Pack](docs/example.png)

## Features

- Full Location and Item Tracking
- Star Counts
- Painting Locks
- Bowser Defeats
- Cap Tracking and Logic
- Cannon Tracking and Logic
- Move Tracking and Logic
- Area Tracking (ER) and Logic
- Map for Visualizing Entrances; Is ER Aware
- Broadcast View for Items
- Auto-Tracking via Archipelago
  - Automatically tracks completed locations and collected items.
  - Automatically tracks Area Randomization if Entrance is Accessible (if enabled)
  - Automatically enables Move Randomization, if enabled.
  - Automatically enables Area Randomization, if enabled.
  - Automatically tracks (un)locked paintings.
  - Automatically displays required star requirements for doors and MIPS (if enabled).
  - ~~Automatically displays required goal requirement.~~
    - Temporarily disabled until a future version that tracks Bowser defeats automatically.
  - Automatically toggles 100 Coin Stars if enabled/disabled.
  - Handles progressive and non-progressive keys automatically.

## Planned Features

- Auto-Tracking for the following settings:
  - Bob-omb Buddies
  - 1-Up Blocks
  - Bowser Defeats
- Additional Maps for each Course and Secret Area.
- _Potentially more..._

## Bug Reports

This is my first time creating such a pack, so if you notice any issues or bugs, please 
[create an issue](https://github.com/ThePhar/APSM64TrackerPack/issues/new/choose) for me to investigate and include the 
exported state, the pack version, your PopTracker version, and what your expectations were.

## Compiling from Source

This pack is built via a TypeScript CLI tool I created called Phakager, which is included in this repo. To use, install 
the latest version of Bun and your package manager of choice (I used `pnpm`), then run install (e.g., `pnpm install`) in
the directory to download all dependencies.

Then run `bun run ./Phakager.ts -h` to see all the possible options that can be run.

## Image Credits

SM64 Move Sprites are based from [this sprite sheet](https://www.deviantart.com/hartflip0218/art/Custom-Mario-sprite-sheet-ver-2-806527057) by Hartflip0218 @ DeviantArt.

All other images are either from Super Mario 64, or created by myself.
