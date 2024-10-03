import dedent from "dedent";

type RuleToken = { type: AllowedTokenTypes, index: number, value?: string | number };
type TokenMatcher = { expr: RegExp, type: AllowedTokenTypes | null, extract?: (match: string) => string };
type AllowedTokenTypes =
    | "OR"
    | "MOVE_GROUP"
    | "CANNON"
    | "STARS"
    | "ACCESS"
    | "NONSTRICT"
    | "NO_ER"
    | "COMPLETED_SUB"
    | "BEATEN_BOWSER2"
    | "LITERAL"
    | "EOL";

const acceptedTokens: TokenMatcher[] = [
    { expr: /\s+/, type: null },
    { expr: /\|/, type: "OR" },
    {
        expr: /(WC|MC|VC|TJ|LJ|BF|SF|WK|DV|GP|KI|CL|LG)(\/(WC|MC|VC|TJ|LJ|BF|SF|WK|DV|GP|KI|CL|LG))*/,
        type: "MOVE_GROUP",
        extract: (match) => match,
    },
    { expr: /(MOVELESS|CANNLESS|CAPLESS)/, type: "NONSTRICT", extract: (match) => match },
    { expr: /CANN/, type: "CANNON" },
    { expr: /STARS:\w+/, type: "STARS", extract: (match) => match.split(":")[1] },
    { expr: /NAR/, type: "NO_ER" },
    { expr: /ACCESS:\w+/, type: "ACCESS", extract: (match) => match.split(":")[1] },
    { expr: /BOWSER2/, type: "BEATEN_BOWSER2" },
    { expr: /SUB/, type: "COMPLETED_SUB" },
    { expr: /\^?\$\w+/, type: "LITERAL", extract: (match) => match },
];

function* tokenize(input: string): Generator<RuleToken> {
    let index = 0;
    while (index < input.length) {
        let hasMatch = false;
        for (const { expr, type, extract } of acceptedTokens) {
            const exprMatcher = new RegExp(expr.source, "y");
            exprMatcher.lastIndex = index;
            const matched = exprMatcher.exec(input);
            if (matched) {
                index += matched[0].length;
                if (type !== null) {
                    const token: RuleToken = { type, index };
                    if (extract) {
                        token.value = extract(matched[0]);
                    }

                    yield token;
                }

                hasMatch = true;
            }
        }

        validate(hasMatch, input, index + 1);
    }

    yield { type: "EOL", index: input.length };
}

function validate(result: boolean, input: string, index: number): void {
    if (result) {
        return;
    }

    const message = dedent(`
        Unexpected token at position: ${index - 1}
        
        Rule substring with error:
        "${input}"
         ${"^".padStart(index, " ")}
    `);

    throw new SyntaxError(message);
}

export function buildRules(input: string | undefined, stage: string): string[] {
    if (!input) {
        return [];
    }

    const rules = new Set<string>();
    const subrules = new Set<string>();
    let lastToken: RuleToken | undefined = undefined;
    for (const token of tokenize(input)) {
        switch (token.type) {
            case "OR":
                validate(!!lastToken && lastToken.type !== "OR", input, token.index);
                rules.add(Array.from(subrules).sort().join(","));
                subrules.clear();
                break;

            case "MOVE_GROUP": {
                const moves = new Set((token.value as string).split("/")); // Remove duplicates.
                subrules.add(`$Has|${Array.from(moves).sort().join("/")}`);
                break;
            }

            case "CANNON":
                subrules.add(`$HasCannon|${stage}`);
                break;

            case "STARS": {
                const value = token.value as string;
                switch (value) {
                    case "F1":
                    case "B1":
                    case "F2":
                    case "F3":
                    case "MIPS1":
                    case "MIPS2":
                        subrules.add(`$HasStars|${value}`);
                        break;

                    default:
                        validate(!isNaN(parseInt(value)), input, token.index);
                        subrules.add(`$HasStars|${value}`);
                }

                break;
            }

            case "ACCESS": {
                const value = token.value as string;
                switch (value) {
                    case "B1":
                    case "F2":
                    case "F3":
                    case "HMC":
                        subrules.add(`^$CanAccess|${value}`);
                        break;

                    default:
                        // Immediate failure.
                        validate(false, input, token.index);
                }

                break;
            }

            case "NONSTRICT":
                subrules.add(`^$StrictAccessibility|${token.value}`);
                break;

            case "NO_ER":
                subrules.add("$NoAreaRando");
                break;

            case "COMPLETED_SUB":
                subrules.add("$Sub");
                break;

            case "BEATEN_BOWSER2":
                subrules.add("$BeatBowser2");
                break;

            case "LITERAL":
                subrules.add(token.value as string);
                break;

            case "EOL":
                validate(!!lastToken && lastToken.type !== "OR", input, token.index);
                rules.add(Array.from(subrules).sort().join(","));
                subrules.clear();
                break;
        }

        lastToken = token;
    }

    return Array.from(rules);
}
