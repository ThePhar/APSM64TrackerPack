import { Location } from "./location.ts";
import { buildRules } from "./rules.ts";

export type RegionData = [
    name: string,
    parent: string | null,
    rules: string,
];

export class Region {
    public readonly name: string;
    public readonly parent: string | null;
    public readonly accessRules: string[] = [];
    public readonly locations: Location[] = [];

    public constructor([name, parent, rules]: RegionData) {
        this.name = name;
        this.parent = parent;
        this.accessRules = buildRules(rules, name.split(":")[0]);
    }

    public get stage(): string {
        if (this.parent) {
            return this.parent.split(":")[0];
        }

        return this.name;
    }

    // public get accessRules(): string[] {
    //     if (!this.parent) {
    //         return this._accessRules;
    //     }
    //
    //     const parentRules = this.parent.accessRules;
    //     if (parentRules.length > 0) {
    //         const rules: string[] = [];
    //         for (const parentRule of parentRules) {
    //             rules.push(...this._accessRules.map((ar) => `${parentRule},${ar}`));
    //         }
    //
    //         return rules;
    //     }
    //
    //     return this._accessRules;
    // }
}
