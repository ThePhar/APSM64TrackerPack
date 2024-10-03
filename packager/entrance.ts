import { buildRules } from "./rules.ts";

export type EntranceData = [
    acronym: EntranceAcronym,
    order: string,
    x: string,
    y: string,
    areaCode: string,
    rules: string,
];

export class Entrance {
    public static readonly entrances: Entrance[] = [];
    public readonly acronym: EntranceAcronym;
    public readonly order: number;
    public readonly coords: [number, number];
    public readonly areaCode: number | null;
    public readonly accessRules: string[];

    public static create(data: EntranceData): void {
        const entrance = new Entrance(data);
        this.entrances.push(entrance);
    }

    private constructor([acronym, order, x, y, areaCode, rules]: EntranceData) {
        this.acronym = acronym;
        this.order = parseInt(order);
        this.coords = [parseInt(x), parseInt(y)];
        this.areaCode = areaCode === "null" ? null : parseInt(areaCode);
        this.accessRules = buildRules(rules, this.acronym);
    }

    public toString(): string {
        return this.acronym;
    }

    public get name(): string {
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
            THIh: "Tiny-Huge Island (Huge)",
            THIt: "Tiny-Huge Island (Tiny)",
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

        return areas[this.acronym];
    }
}

export type EntranceAcronym =
    | "BoB"
    | "WF"
    | "JRB"
    | "CCM"
    | "BBH"
    | "HMC"
    | "LLL"
    | "SSL"
    | "DDD"
    | "SL"
    | "WDW"
    | "TTM"
    | "THIh"
    | "THIt"
    | "TTC"
    | "RR"
    | "BitDW"
    | "BitFS"
    | "BitS"
    | "TotWC"
    | "CotMC"
    | "VCutM"
    | "PSS"
    | "SA"
    | "WMotR";
