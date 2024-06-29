local course = "BOB"

function CanAccessBOBIsland()
    return GetAccessibility({
        (HasCannon(course)),
        (HasMoves("TJ") and HasCap("WC") and StrictCannonAccessibilityLevel()),
        (HasMoves("TJ") and math.min(StrictCannonAccessibilityLevel(), StrictMovementAccessibilityLevel())),
    })
end

function CanAccessBOBWings()
    return GetAccessibility({
        (HasCannon(course) and HasCap("WC")),
        (HasCannon(course) and StrictCapAccessibilityLevel()),
    })
end

function CanAccessBOBChainChomp()
    return GetAccessibility({
        (HasMoves("GP")),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessBOBCoins()
    return GetAccessibility({
        (HasCannon(course) and HasCap("WC")),
        (HasMoves("TJ") and HasCap("WC") and StrictCannonAccessibilityLevel()),
    })
end
