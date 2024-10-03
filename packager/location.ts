import { Region } from "./region.ts";
import { buildRules } from "./rules.ts";

export type LocationData = [
    name: string,
    region: string,
    code: number,
    type: LocationType,
    // coords: [x: number, y: number], todo: someday
    rules?: string,
];

export class Location {
    public static readonly locations: Location[] = [];
    public readonly name: string;
    public readonly region: Region;
    public readonly code: number;
    public readonly type: LocationType;
    private readonly _accessRules: string[];

    public static create(data: LocationData): void {
        const location = new Location(data);
        this.locations.push(location);
    }

    private constructor([name, region, code, type, rules]: LocationData) {
        this.name = name;
        this.region = Region.regions[region];
        this.code = code;
        this.type = type;
        this._accessRules = buildRules(rules ?? "", region.split(":")[0]);
    }

    public toString(): string {
        return this.name;
    }

    public get itemCode(): string {
        return `__location_item_${this.code}`;
    }

    public get visibilityRules(): string[] {
        switch (this.type) {
            case "100Coins":
                return ["$ShowCoinStars"];
            case "Buddy":
                return ["$ShowBuddies"];
            case "MushBlock":
                return ["$ShowMushBlocks"];
        }

        return [];
    }

    public get icons(): [missing: string, checked: string] {
        switch (this.type) {
            case "Star":
                return ["images/star.png", "images/star_collected.png"];
            case "100Coins":
                return ["images/star_coin.png", "images/star_collected.png"];
            case "RedCoins":
                return ["images/star_red.png", "images/star_collected.png"];
            case "Buddy":
                return ["images/buddy.png", "images/buddy_checked.png"];
            case "BowserKey":
                return ["images/keys/key.png", "images/keys/key_checked.png"];
            case "RedSwitch":
                return ["images/blocks/block_red.png", "images/blocks/block_checked.png"];
            case "GreenSwitch":
                return ["images/blocks/block_green.png", "images/blocks/block_checked.png"];
            case "BlueSwitch":
                return ["images/blocks/block_blue.png", "images/blocks/block_checked.png"];
            case "MushBlock":
                return ["images/blocks/block_1up.png", "images/blocks/block_checked.png"];
        }
    }

    public get stage(): string {
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

        // @ts-expect-error Any other value should not happen during runtime.
        return areas[this.region.stage] as string;
    }

    public get accessRules(): string[] {
        const regionRules = this.region.accessRules;
        if (regionRules.length > 0) {
            const rules: string[] = [];
            for (const regionRule of regionRules) {
                rules.push(...this._accessRules.map((ar) => `${regionRule},${ar}`));
            }

            if (rules.length > 0) {
                return rules;
            }

            return regionRules;
        }

        return this._accessRules;
    }
}

type LocationType =
    | "Star"
    | "100Coins"
    | "RedCoins"
    | "Buddy"
    | "BowserKey"
    | "RedSwitch"
    | "GreenSwitch"
    | "BlueSwitch"
    | "MushBlock";
