// @ts-check
// noinspect JSCheckFunctionSignatures

import eslint from "@eslint/js";
import stylistic from "@stylistic/eslint-plugin";
import importSort from "eslint-plugin-simple-import-sort";
import tslint from "typescript-eslint";

export default tslint.config(
    eslint.configs.recommended,
    ...tslint.configs.recommendedTypeChecked,
    stylistic.configs["recommended-flat"],
    {
        ignores: ["node_modules", "build"],
        plugins: {
            "@stylistic": stylistic,
            "simple-import-sort": importSort,
        },
        rules: {
            "@stylistic/arrow-parens": ["error", "always"],
            "@stylistic/brace-style": ["error", "1tbs"],
            "@stylistic/indent": ["error", 4],
            "@stylistic/indent-binary-ops": ["error", 4],
            "@stylistic/quotes": ["error", "double"],
            "@stylistic/semi": ["error", "always"],
            "simple-import-sort/imports": "error",
            "simple-import-sort/exports": "error",
        },
        languageOptions: {
            ecmaVersion: "latest",
            sourceType: "module",
            parserOptions: {
                projectService: {
                    allowDefaultProject: ["*.js", "*.mjs"],
                },
                tsconfigRootDir: import.meta.dirname,
            },
        },
    },
);
