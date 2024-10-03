import * as fs from "node:fs/promises";
import * as process from "node:process";

import dedent from "dedent";
import { native as rmdir } from "rimraf";
import { parseArgs } from "util";
import { zip } from "zip-a-folder";

import { compileAll } from "./packager/compile.ts";
import { ManifestVersion, VersionsJSON } from "./packager/versioning.ts";

const { values: args } = parseArgs({
    args: Bun.argv,
    allowPositionals: true,
    strict: true,
    options: {
        compile: {
            type: "boolean",
            short: "c",
        },
        package: {
            type: "boolean",
            short: "k",
        },
        update_versioning: {
            type: "boolean",
            short: "v",
        },
        increment_major: {
            type: "boolean",
            short: "i",
        },
        increment_minor: {
            type: "boolean",
            short: "m",
        },
        increment_patch: {
            type: "boolean",
            short: "p",
        },
        production: {
            type: "boolean",
            short: "P",
        },
        help: {
            type: "boolean",
            short: "h",
        },
    },
});

// Print help text.
if (Object.keys(args).length === 0 || args.help) {
    console.log(dedent(`
        usage: bun run ./Phakager.ts [options]
        
        A Bun CLI package bundler/transpiler for this PopTracker pack. More information can be found on the GitHub repo:
        https://github.com/ThePhar/APSM64TrackerPack
        
        options:
            -h, --help              Show this help message and exit; ignores all other options.
            -c, --compile           Runs transpilation step and outputs result to build dir.
            -k, --package           Gathers all relevant files from build and zips into packs dir.
            -v, --update_versioning Adds current build to versions.json file; ignored if -kP is omitted.
            -i, --increment_major   Increments the major version component in the manifest.json file.
            -m, --increment_minor   Increments the minor version component in the manifest.json file.
            -p, --increment_patch   Increments the patch version component in the manifest.json file.
            -P, --production        Marks current package.json file as a production build, without prerelease metadata.
            
        "I blame Phar." -Phar
    `));

    process.exit(0);
}

const GAME_NAME = "Super Mario 64";
const MINIMUM_POPTRACKER_VERSION = "0.29.0";
const VERSIONS_URL = "https://raw.githubusercontent.com/ThePhar/APSM64TrackerPack/main/versions.json";

// Track run time.
const startTime = performance.now();

// Compilation steps.
if (args.compile) {
    // Update package.json version.
    const packageJSON = await Bun.file("package.json").json() as { version: string, name: string, description: string };
    const version = new ManifestVersion(packageJSON.version);

    version.major += args.increment_major ? 1 : 0;
    version.minor += args.increment_minor ? 1 : 0;
    version.patch += args.increment_patch ? 1 : 0;
    packageJSON.version = version.output(!args.production);
    await Bun.write("package.json", JSON.stringify(packageJSON, null, 4));

    console.log("[Phakager]: Clearing build directory...");
    // Clear current build directory.
    await rmdir(`${import.meta.dirname}/build`);
    await fs.mkdir("build");

    // Static Files
    console.log("[Phakager]: Copying static files...");
    for (const data of await fs.readdir("static", { recursive: true, withFileTypes: true })) {
        const path = ["build", ...data.parentPath.split("/").slice(1), data.name].join("/");
        if (data.isDirectory()) {
            await fs.mkdir(path);
            continue;
        }

        const file = Bun.file(`${data.parentPath}/${data.name}`);
        await Bun.write(`${path}`, file);
    }

    // Manifest
    console.log("[Phakager]: Generating manifest.json...");
    const manifest = {
        name: packageJSON.description,
        package_uid: packageJSON.name,
        package_version: packageJSON.version,
        min_poptracker_version: MINIMUM_POPTRACKER_VERSION,
        versions_url: VERSIONS_URL,
        game_name: GAME_NAME,
        platform: "pc",
        author: "Phar",
        variants: {
            standard: {
                display_name: "Full Logic & Area Randomization Tracker",
                flags: ["ap"],
            },
        },
    };
    await Bun.write("build/manifest.json", JSON.stringify(manifest, null, 4));

    // Compile remaining files.
    console.log("[Phakager]: Compiling abstract files...");
    await compileAll(import.meta.dirname);
}

// Package steps.
if (args.package) {
    try {
        await fs.mkdir("packs");
    } catch { /* If failed, usually means folder already exists, so ignore this. */ }
    const { name, version } = await Bun.file("package.json").json() as { version: string, name: string };

    // Zip contents.
    console.log(`[Phakager]: Compressing build dir to 'packs/${name}_${version}.zip'...`);
    await zip("build", `packs/${name}_${version}.zip`);

    if (args.update_versioning) {
        console.log("[Phakager]: Calculating package hash...");
        const versionsJSON = await Bun.file("versions.json").json() as VersionsJSON;
        const pack = await Bun.file(`packs/${name}_${version}.zip`).bytes();
        const hasher = new Bun.CryptoHasher("sha256");
        hasher.update(pack);
        const hash = hasher.digest("hex");

        console.log("[Phakager]: Updating versions.json...");
        let changelog: string[] = [];
        if (await fs.exists(`docs/changelogs/${version}.json`)) {
            changelog = await Bun.file(`docs/changelogs/${version}.json`).json() as string[];
        } else {
            console.warn(`\tNo changelogs file found for ${version}! Outputting an empty changelog.`);
        }

        versionsJSON.versions = [
            {
                package_version: version,
                download_url: `https://github.com/ThePhar/APSM64TrackerPack/releases/download/${version}/${name}_${version}.zip`,
                sha256: hash,
                changelog,
            },
            ...versionsJSON.versions,
        ];
        await Bun.write("versions.json", JSON.stringify(versionsJSON, null, 4));
    }
}

// Post results.
const finalTime = Math.round((performance.now() - startTime + Number.EPSILON) * 10) / 10_000;
console.log(`[Phakager]: Finished processing in ${finalTime} seconds.`);

// import { mkdir, readdir } from "node:fs/promises";
//
// import { parse } from "yaml";
//
// import { entrances, locations } from "./definitions.ts";
//
// async function buildStaticData(folder: string): Promise<void> {
//     const inPath = `${import.meta.dirname}/../data/${folder}`;
//     const files = await readdir(inPath);
//     for (const file of files) {
//         const outPath = `${import.meta.dirname}/../pack/${folder}`;
//         try {
//             await mkdir(outPath);
//         } catch { /* fine if it already exists. */ }
//
//         const buffer = await Bun.file(`${inPath}/${file}`).text();
//         const obj = parse(buffer) as { data: unknown };
//         await Bun.write(`${outPath}/${file.split(".")[0]}.json`, JSON.stringify(obj.data, null, "\t"));
//     }
// }
//
// async function buildAreaRando(): Promise<void> {
//     const entranceItems = [];
//     const destinationItems = [];
//     for (const entrance of entrances) {
//         entranceItems.push({
//             name: `${entrance.name} - Entrance`,
//             type: "toggle",
//             img: `images/er_legend/er_${entrance.acronym.toLowerCase()}_ent.png`,
//             disabled_img_mods: "none",
//             codes: `__er_${entrance.acronym}_ent`,
//         });
//
//         destinationItems.push({
//             name: `${entrance.name} - Destination Symbol`,
//             type: "progressive",
//             loop: true,
//             initial_stage_idx: entrance.acronym === "BitS" ? entrance.order : 0,
//             allow_disabled: false,
//             codes: `__er_${entrance.acronym}_dst`,
//             stages: [{
//                 name: "Unknown Destination",
//                 img: "images/er_legend/er_unknown_dst.png",
//                 inherit_codes: false,
//             }],
//         });
//
//         const destinationItem = destinationItems[destinationItems.length - 1];
//         for (const destination of entrances) {
//             destinationItem.stages.push({
//                 name: `${destination.name} - Destination`,
//                 img: `images/er_legend/er_${destination.acronym.toLowerCase()}_dst.png`,
//                 inherit_codes: false,
//             });
//         }
//
//         const output = JSON.stringify([...entranceItems, ...destinationItems], null, "\t");
//         await Bun.write(`${import.meta.dirname}/../pack/items/area_rando.json`, output);
//     }
// }
//
// async function buildLocations(): Promise<void> {
//     const locationItems: unknown[] = [{
//         name: "Enter Stage and Set Entrance",
//         type: "toggle",
//         codes: "__location_item_null",
//     }];
//
//     for (const location of locations) {
//         locationItems.push({
//             name: location.name,
//             type: "toggle",
//             codes: location.itemCode,
//             img: location.icons[1],
//             disabled_img: location.icons[0],
//             disabled_img_mods: "none",
//         });
//     }
//
//     const output = JSON.stringify(locationItems, null, "\t");
//     await Bun.write(`${import.meta.dirname}/../pack/items/locations.json`, output);
// }
//
// async function buildCastleEntrances(): Promise<void> {
//     const areas = {
//         BoB: "Bob-omb Battlefield",
//         WF: "Whomp's Fortress",
//         JRB: "Jolly Roger Bay",
//         CCM: "Cool, Cool Mountain",
//         BBH: "Big Boo's Haunt",
//         HMC: "Hazy Maze Cave",
//         LLL: "Lethal Lava Land",
//         SSL: "Shifting Sand Land",
//         DDD: "Dire, Dire Docks",
//         SL: "Snowman's Land",
//         WDW: "Wet-Dry World",
//         TTM: "Tall, Tall Mountain",
//         THI: "Tiny-Huge Island",
//         TTC: "Tick Tock Clock",
//         RR: "Rainbow Ride",
//         BitDW: "Bowser in the Dark World",
//         BitFS: "Bowser in the Fire Sea",
//         BitS: "Bowser in the Sky",
//         TotWC: "Tower of the Wing Cap",
//         CotMC: "Cavern of the Metal Cap",
//         VCutM: "Vanish Cap under the Moat",
//         PSS: "Princess's Secret Slide",
//         SA: "Secret Aquarium",
//         WMotR: "Wing Mario over the Rainbow",
//     } as const;
//
//     const overworldEntrances: unknown[] = [];
//     for (const entrance of entrances) {
//         const entranceNode: { [p: string]: unknown, children: unknown[] } = {
//             name: `${entrance.name} Entrance`,
//             access_rules: entrance.accessRules,
//             children: [
//                 {
//                     name: "Unknown Stage",
//                     visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
//                     access_rules: entrance.accessRules,
//                     map_locations: [{
//                         map: "map_castle",
//                         x: entrance.coords[0],
//                         y: entrance.coords[1],
//                     }],
//                     sections: [{
//                         name: "Enter Stage and Set Entrance",
//                         hosted_item: "__location_item_null",
//                     }],
//                 },
//                 {
//                     name: "Unknown Stage [Scout]",
//                     visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
//                     access_rules: `{$IsUnknownDestination|${entrance.acronym}}`,
//                     map_locations: [{
//                         map: "map_castle",
//                         x: entrance.coords[0],
//                         y: entrance.coords[1],
//                     }],
//                     sections: [{
//                         name: "Enter Stage and Set Entrance",
//                         hosted_item: "__location_item_null",
//                     }],
//                 },
//                 {
//                     name: "Unknown Stage [Z]",
//                     access_rules: entrance.accessRules,
//                     visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
//                     map_locations: [{
//                         map: "map_castle",
//                         x: entrance.coords[0] + 17,
//                         y: entrance.coords[1] + 16,
//                         size: 16,
//                         shape: "diamond",
//                     }],
//                     sections: [{
//                         name: "Green: Accessible\nYellow: Sequence Break Required\nRed: Logically Inaccessible",
//                         hosted_item: "__location_item_null",
//                     }],
//                 },
//             ],
//         };
//
//         for (const [acronym, stage] of Object.entries(areas)) {
//             const locationNode: { [p: string]: unknown, sections: unknown[] } = {
//                 name: stage,
//                 visibility_rules: `$IsSelectedDestination|${acronym}|${entrance.acronym}`,
//                 map_locations: [{
//                     map: "map_castle",
//                     x: entrance.coords[0],
//                     y: entrance.coords[1],
//                 }],
//                 sections: [],
//             };
//
//             for (const location of locations.filter((l) => l.region.stage === acronym)) {
//                 locationNode.sections.push({
//                     name: location.name,
//                     hosted_item: location.itemCode,
//                     access_rules: location.accessRules,
//                     visibility_rules: location.visibilityRules,
//                 });
//             }
//
//             entranceNode.children.push(locationNode);
//         }
//
//         overworldEntrances.push(entranceNode);
//     }
//
//     const output = JSON.stringify(overworldEntrances, null, "\t");
//     await Bun.write(`${import.meta.dirname}/../pack/locations/castle_entrances.json`, output);
// }
//
// void buildStaticData("items");
// void buildAreaRando();
// void buildLocations();
// void buildCastleEntrances();
