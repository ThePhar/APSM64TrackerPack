export type LocationData = [
    name: string,
    region: string,
    code: number,
    type: string,
    // coords: [x: number, y: number], todo: someday
    rules?: string,
];

export type RegionData = [
    name: string,
    parent: string,
    rules: string,
];

export type EntranceData = [
    name: string,
    order: number,
    coords: [x: number, y: number],
    id: number | null,
    rules: string,
];

export function createEntrances(...entrances: EntranceData): void {

}

export function createRegions(...regions: RegionData): void {

}

export function createLocations(...locations: LocationData): void {

}
