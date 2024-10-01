import { mkdir, readdir } from "node:fs/promises";

import { parse } from "yaml";

import { entrances, locations } from "./definitions.ts";

async function buildStaticData(folder: string): Promise<void> {
    const inPath = `${import.meta.dirname}/../data/${folder}`;
    const files = await readdir(inPath);
    for (const file of files) {
        const outPath = `${import.meta.dirname}/../pack/${folder}`;
        try {
            await mkdir(outPath);
        } catch { /* fine if it already exists. */ }

        const buffer = await Bun.file(`${inPath}/${file}`).text();
        const obj = parse(buffer) as { data: unknown };
        await Bun.write(`${outPath}/${file.split(".")[0]}.json`, JSON.stringify(obj.data, null, "\t"));
    }
}

async function buildAreaRando(): Promise<void> {
    const entranceItems = [];
    const destinationItems = [];
    for (const entrance of entrances) {
        entranceItems.push({
            name: `${entrance.name} - Entrance`,
            type: "toggle",
            img: `images/er_legend/er_${entrance.acronym.toLowerCase()}_ent.png`,
            disabled_img_mods: "none",
            codes: `__er_${entrance.acronym}_ent`,
        });

        destinationItems.push({
            name: `${entrance.name} - Destination Symbol`,
            type: "progressive",
            loop: true,
            initial_stage_idx: 0,
            allow_disabled: false,
            codes: `__er_${entrance.acronym}_dst`,
            stages: [{
                name: "Unknown Destination",
                img: "images/er_legend/er_unknown_dst.png",
                inherit_codes: false,
            }],
        });

        const destinationItem = destinationItems[destinationItems.length - 1];
        for (const destination of entrances) {
            destinationItem.stages.push({
                name: `${destination.name} - Destination`,
                img: `images/er_legend/er_${destination.acronym.toLowerCase()}_dst.png`,
                inherit_codes: false,
            });
        }

        const output = JSON.stringify([...entranceItems, ...destinationItems], null, "\t");
        await Bun.write(`${import.meta.dirname}/../pack/items/area_rando.json`, output);
    }
}

async function buildLocations(): Promise<void> {
    const locationItems: unknown[] = [{
        name: "Enter Stage and Set Entrance",
        type: "toggle",
        codes: "__location_item_null",
    }];

    for (const location of locations) {
        locationItems.push({
            name: location.name,
            type: "toggle",
            codes: location.itemCode,
            img: location.icons[1],
            disabled_img: location.icons[0],
            disabled_img_mods: "none",
        });
    }

    const output = JSON.stringify(locationItems, null, "\t");
    await Bun.write(`${import.meta.dirname}/../pack/items/locations.json`, output);
}

async function buildCastleEntrances(): Promise<void> {
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
    } as const;

    const overworldEntrances: unknown[] = [];
    for (const entrance of entrances) {
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
                {
                    name: "Unknown Stage [Z]",
                    access_rules: entrance.accessRules,
                    visibility_rules: `$IsUnknownDestination|${entrance.acronym}`,
                    map_locations: [{
                        map: "map_castle",
                        x: entrance.coords[0] + 17,
                        y: entrance.coords[1] + 16,
                        size: 16,
                        shape: "diamond",
                    }],
                    sections: [{
                        name: "Green: Accessible\nYellow: Sequence Break Required\nRed: Logically Inaccessible",
                        hosted_item: "__location_item_null",
                    }],
                },
            ],
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

            for (const location of locations.filter((l) => l.region.stage === acronym)) {
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
    }

    const output = JSON.stringify(overworldEntrances, null, "\t");
    await Bun.write(`${import.meta.dirname}/../pack/locations/castle_entrances.json`, output);
}

void buildStaticData("items");
void buildAreaRando();
void buildLocations();
void buildCastleEntrances();
