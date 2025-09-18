import { mkdir, readdir } from "node:fs/promises";

import { parse as parseYAML } from "yaml";

import { Entrance, EntranceData } from "./entrance.ts";
import { Location, LocationData } from "./location.ts";
import { Region, RegionData } from "./region.ts";

const areas = {
    BoB: "Bob-omb Battlefield",
    WF: "Whomp's Fortress",
    JRB: "Jolly Roger Bay",
    CCM: "Cool, Cool Mountain",
    BBH: "Big Boo's Haunt",
    HMC: "Hazy Maze Cave",
    LLL: "Lethal Lava Land",
    SSL: "Shifting Sand Land",
    DDD: "Dire, Dire Docks",
    SL: "Snowman's Land",
    WDW: "Wet-Dry World",
    TTM: "Tall, Tall Mountain",
    THI: "Tiny-Huge Island",
    TTC: "Tick Tock Clock",
    RR: "Rainbow Ride",
    BitDW: "Bowser in the Dark World",
    BitFS: "Bowser in the Fire Sea",
    BitS: "Bowser in the Sky",
    TotWC: "Tower of the Wing Cap",
    CotMC: "Cavern of the Metal Cap",
    VCutM: "Vanish Cap under the Moat",
    PSS: "Princess's Secret Slide",
    SA: "Secret Aquarium",
    WMotR: "Wing Mario over the Rainbow",
    MKC: "Mushroom Kingdom Castle",
} as const;

async function readCSV<T>(cwd: string, path: string): Promise<T[]> {
    const buffer = await Bun.file(`${cwd}/${path}`).text();
    const rows: T[] = [];
    for (const row of buffer.trim().split("\n").slice(1)) {
        rows.push(row
            .split(/(?<!\\),/)
            .map((d) => d.replaceAll("\\,", ","))
            .map((d) => d.replaceAll("\"", "")) as T,
        );
    }

    return rows;
}

async function compileStaticData(cwd: string): Promise<void> {
    const dirs = ["items", "layouts", "locations", "maps"];
    for (const dir of dirs) {
        const inPath = `${cwd}/data/${dir}`;
        const outPath = `${cwd}/build/${dir}`;
        try {
            await mkdir(outPath);
        } catch { /* If dir exists, do nothing. */ }

        for (const file of await readdir(inPath)) {
            console.log(`\tCompiling 'data/${dir}/${file}'`);
            const buffer = await Bun.file(`${inPath}/${file}`).text();
            const obj = parseYAML(buffer) as { data: unknown };
            await Bun.write(`${outPath}/${file.split(".")[0]}.json`,
                "/* This file was automatically generated via Phakager. Do not make manual edits to this file. */\n"
                + JSON.stringify(obj.data, null, 4),
            );
        }
    }
}

async function compileAreaRandomizerItems(cwd: string): Promise<void> {
    const entranceItems = [];
    const destinationItems = [];
    for (const entrance of Entrance.entrances) {
        entranceItems.push({
            name: `${entrance.name} - Entrance`,
            type: "toggle",
            img: `images/er_legend/er_${entrance.acronym.toLowerCase()}_ent.png`,
            disabled_img_mods: "none",
            codes: `__er_${entrance.acronym}_ent`,
        });

        const destinationItem = {
            name: `${entrance.name} - Destination Symbol`,
            type: "progressive",
            loop: true,
            initial_stage_idx: entrance.acronym === "BitS" ? entrance.order : 0,
            allow_disabled: false,
            codes: `__er_${entrance.acronym}_dst`,
            stages: [{
                name: "??? - Destination",
                img: "images/er_legend/er_unknown_dst.png",
                inherit_codes: false,
            }],
        };

        for (const destination of Entrance.entrances) {
            destinationItem.stages.push({
                name: `${destination.name} - Destination`,
                img: `images/er_legend/er_${destination.acronym.toLowerCase()}_dst.png`,
                inherit_codes: false,
            });
        }

        destinationItems.push(destinationItem);
    }

    console.log("\tBuilding 'items/area_rando.json'");
    const output = JSON.stringify([...entranceItems, ...destinationItems], null, 4);
    await Bun.write(`${cwd}/build/items/area_rando.json`,
        "/* This file was automatically generated via Phakager. Do not make manual edits to this file. */\n" + output,
    );
}

async function compileLocationItems(cwd: string): Promise<void> {
    const locationItems = [];
    locationItems.push({
        name: "Enter Stage and Set Entrance",
        type: "toggle",
        codes: "__location_item_null",
    });

    for (const location of Location.locations) {
        locationItems.push({
            name: location.name,
            type: "toggle",
            codes: location.itemCode,
            img: location.icons[1],
            disabled_img: location.icons[0],
            disabled_img_mods: "none",
        });
    }

    console.log("\tBuilding 'items/locations.json'");
    const output = JSON.stringify(locationItems, null, 4);
    await Bun.write(`${cwd}/build/items/locations.json`,
        "/* This file was automatically generated via Phakager. Do not make manual edits to this file. */\n" + output,
    );
}

async function compileCastleMapEntranceLocations(cwd: string): Promise<void> {
    const overworldEntrances: unknown[] = [];
    for (const entrance of Entrance.entrances) {
        const entranceNode: { [p: string]: unknown, children: unknown[] } = {
            name: `${entrance.name} Entrance`,
            access_rules: entrance.accessRules,
            children: [
                {
                    name: "Unknown Stage",
                    visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
                    access_rules: entrance.accessRules,
                    map_locations: [{
                        map: "map_castle",
                        x: entrance.coords[0],
                        y: entrance.coords[1],
                    }],
                    sections: [{
                        name: "Enter Stage and Set Entrance",
                        hosted_item: "__location_item_null",
                    }],
                },
                {
                    name: "Unknown Stage [Scout]",
                    visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
                    access_rules: `{$IsUnknownDestination|${entrance.acronym}}`,
                    map_locations: [{
                        map: "map_castle",
                        x: entrance.coords[0],
                        y: entrance.coords[1],
                    }],
                    sections: [{
                        name: "Enter Stage and Set Entrance",
                        hosted_item: "__location_item_null",
                    }],
                },
            ],
        };

        const scoutNode = {
            name: "[Z] Entrance Accessibility",
            access_rules: [...entrance.accessRules, ...entrance.scoutRules.map((i) => `{${i}}`)],
            visibility_rules: ["$AreaRando"],
            children: [{
                name: `Entrance Accessibility for ${entrance.name}`,
                map_locations: [{
                    map: "map_castle",
                    x: entrance.coords[0] + 16,
                    y: entrance.coords[1] + 16,
                    size: 16,
                    shape: "trapezoid",
                }],
                sections: [{
                    name: "Green: Accessible\n"
                        + "Yellow: Sequence Break Required\n"
                        + "Blue: Potentially Scoutable (i.e., TTC hands)\n"
                        + "Red: Logically Inaccessible",
                    hosted_item: `__er_${entrance.acronym}_dst`,
                }],
            }],
        };

        for (const [acronym, stage] of Object.entries(areas)) {
            const locationNode: { [p: string]: unknown, sections: unknown[] } = {
                name: stage,
                visibility_rules: `$IsSelectedDestination|${acronym}|${entrance.acronym}`,
                map_locations: [{
                    map: "map_castle",
                    x: entrance.coords[0],
                    y: entrance.coords[1],
                }],
                sections: [],
            };

            for (const location of Location.locations.filter((l) => l.region.stage === acronym)) {
                locationNode.sections.push({
                    name: location.name,
                    hosted_item: location.itemCode,
                    access_rules: location.accessRules,
                    visibility_rules: location.visibilityRules,
                });
            }

            entranceNode.children.push(locationNode);
        }

        overworldEntrances.push(entranceNode);
        overworldEntrances.push(scoutNode);
    }

    console.log("\tBuilding 'locations/castle_entrances.json'");
    const output = JSON.stringify(overworldEntrances, null, 4);
    await Bun.write(`${cwd}/build/locations/castle_entrances.json`,
        "/* This file was automatically generated via Phakager. Do not make manual edits to this file. */\n" + output,
    );
}

async function compileLocationMappingLua(cwd: string): Promise<void> {
    let output = "LOCATION_MAPPING = {\n";
    for (const location of Location.locations) {
        output += `    [${location.code}] = {"${location.itemCode}"}, -- ${location.region.stage.padEnd(5)} - ${location.name}\n`;
    }

    console.log("\tBuilding 'scripts/autotracking/location_mapping.lua'");
    await Bun.write(`${cwd}/build/scripts/autotracking/location_mapping.lua`,
        "-- This file was automatically generated via Phakager. Do not make manual edits to this file.\n" + output + "}",
    );
}

export async function compileAll(cwd: string): Promise<void> {
    const entrances = await readCSV<EntranceData>(cwd, "data/entrances.csv");
    const regions = await readCSV<RegionData>(cwd, "data/regions.csv");
    const locations = await readCSV<LocationData>(cwd, "data/locations.csv");

    // Pre-build entrances, regions, and locations.
    entrances.forEach((entrance) => Entrance.create(entrance));
    for (const stage of Object.keys(areas)) {
        Region.create([stage, null, ""]);
    }

    regions.forEach((region) => Region.create(region));
    locations.forEach((location) => Location.create(location));

    // Compile everything.
    await compileStaticData(cwd);
    await compileAreaRandomizerItems(cwd);
    await compileLocationItems(cwd);
    await compileCastleMapEntranceLocations(cwd);
    await compileLocationMappingLua(cwd);
}
