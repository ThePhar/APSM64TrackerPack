export class ManifestVersion {
    public major: number;
    public minor: number;
    public patch: number;
    public prerelease: boolean = false;

    public get timestamp(): number {
        return Math.floor(Date.now() / 1000);
    }

    public constructor(version: string) {
        // I sure am glad the folks who manage semver provided this cause gosh-damn this thing is terrifying.
        const regex = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/;
        const matches = regex.exec(version);
        if (!matches) {
            throw new Error(`Unexpected version string: ${version}`);
        }

        this.major = parseInt(matches[1]);
        this.minor = parseInt(matches[2]);
        this.patch = parseInt(matches[3]);
        // Don't care about prerelease/metadata substring, as we override in our use case anyway.
    }

    public output(prerelease: boolean = false) {
        let version = `${this.major}.${this.minor}.${this.patch}`;
        if (prerelease) {
            version += `-pre+${this.timestamp}`;
        }

        return version;
    }
}
