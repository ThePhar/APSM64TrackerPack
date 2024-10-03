import { mkdir, readdir } from "node:fs/promises";

import { parse } from "yaml";

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
            const obj = parse(buffer) as { data: unknown };
            await Bun.write(`${outPath}/${file.split(".")[0]}.json`,
                "/* This file was automatically generated via Phakager. Do not make manual edits to this file. */\n"
                + JSON.stringify(obj.data, null, 4),
            );
        }
    }
}

export async function compileAll(cwd: string): Promise<void> {
    await compileStaticData(cwd);
}
