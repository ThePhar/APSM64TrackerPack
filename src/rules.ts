/**
 * Creates a PopTracker-compatible rules array.
 * @remarks OR (`|`) has higher priority than AND (`&`). Parens are not supported (yet).
 * @param expressions
 */
export function rule(expressions: string): string[] {
    const orExpressions = expressions.split("|").map((expr) => expr.trim());
    const allRules: string[] = [];

    for (const orExpression of orExpressions) {
        const rules: string[] = [];
        const andExpressions = orExpression.split("&").map((expr) => expr.trim());
        for (const andExpression of andExpressions) {
            switch (andExpression) {
                // Strict Accessibility Modifiers
                case "MOVELESS":
                    rules.push("^$MoveAccessibility");
                    break;
                case "CAPLESS":
                    rules.push("^$CapsAccessibility");
                    break;
                case "CANNLESS":
                    rules.push("^$CannAccessibility");
                    break;

                // Has Caps
                case "VC":
                case "MC":
                case "WC":
                    rules.push(`$HasCap|${andExpression}`);
                    break;

                // No Area Randomizer
                case "NAR":
                    rules.push("$NoAreaRandomizer");
                    break;

                // Special DDD
                case "SUB":
                    rules.push("$HasCompleted|3626056"); // DDD: Bowser's Sub Star
                    break;
                case "BEATBOWSER2":
                    rules.push("$HasCompleted|3626179"); // Second Bowser Defeat
                    break;

                // HMC Access
                case "HMC":
                    rules.push("^$CanAccessHMC");
                    break;

                // Star/Key Requirements
                case "BASEMENT":
                    rules.push("$HasKey|B");
                    break;
                case "SECONDFLOOR":
                    rules.push("$HasKey|U");
                    break;
                case "THIRDFLOOR":
                    rules.push("$HasKey|U,$HasStars|F2");
                    break;
                case "BOWSER1":
                    rules.push("$HasStars|F1");
                    break;
                case "BOWSER2":
                    rules.push("$HasStars|B1");
                    break;
                case "BOWSER3":
                    rules.push("$HasStars|F3");
                    break;
                case "MIPS1":
                    rules.push("$HasStars|MIPS1");
                    break;
                case "MIPS2":
                    rules.push("$HasStars|MIPS2");
                    break;

                default:
                    // Star Requirements
                    if (andExpression.startsWith("STARS:")) {
                        rules.push(`$HasStars|${andExpression.replace("STARS:", "")}`);
                        break;
                    }

                    // Has Cannon
                    if (andExpression.startsWith("CANN:")) {
                        rules.push(`$HasCannon|${andExpression.replace("CANN:", "")}`);
                        break;
                    }

                    // Move Requirements
                    rules.push(`$HasMoves|${andExpression}`);
            }
        }

        // Append new rule.
        allRules.push(rules.join(","));
    }

    return allRules;
}
