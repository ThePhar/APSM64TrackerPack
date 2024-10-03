import { buildRules } from "./rules.ts";

export type RegionData = [
    name: string,
    parent: string | null,
    rules: string,
];

export class Region {
    public static readonly regions: Record<string, Region> = {};
    public readonly name: string;
    public readonly parent: Region | null = null;
    private readonly _accessRules: string[] = [];

    public static create(data: RegionData): void {
        const region = new Region(data);
        this.regions[region.name] = region;
    }

    private constructor([name, parent, rules]: RegionData) {
        this.name = name;
        this._accessRules = buildRules(rules, name.split(":")[0]);

        if (parent) {
            this.parent = Region.regions[parent];
        }
    }

    public get stage(): string {
        if (this.parent) {
            return this.parent.stage;
        }

        return this.name;
    }

    public get accessRules(): string[] {
        if (!this.parent) {
            return this._accessRules;
        }

        const parentRules = this.parent.accessRules;
        if (parentRules.length > 0) {
            const rules: string[] = [];
            for (const parentRule of parentRules) {
                rules.push(...this._accessRules.map((ar) => `${parentRule},${ar}`));
            }

            return rules;
        }

        return this._accessRules;
    }
}
