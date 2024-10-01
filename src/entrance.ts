export class Entrance {
    public readonly acronym: ValidEntrance;
    public readonly order: number;
    public readonly coords: [number, number];
    public readonly areaCode: number | null;
    public readonly accessRules: string[];

    public constructor(
        acronym: ValidEntrance,
        order: number,
        coords: [number, number],
        areaCode: number | null = null,
        accessRules: string[] = [],
    ) {
        this.acronym = acronym;
        this.order = order;
        this.coords = coords;
        this.areaCode = areaCode;
        this.accessRules = accessRules;
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

type ValidEntrance =
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
