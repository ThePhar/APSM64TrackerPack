local course = "BOB"

function CanAccessBOBIsland()
    return (
        (HasCannon(course)) or
        (HasMoves("TJ") and HasCap("WC") and StrictCannonAccessibilityLevel()) or
        (HasMoves("TJ") and math.min(StrictCannonAccessibilityLevel(), StrictMovementAccessibilityLevel()))
    )
end

function CanAccessBOBWings()
    return (
        (HasCannon(course) and HasCap("WC")) or
        (math.min(StrictCannonAccessibilityLevel(), StrictCapAccessibilityLevel()))
    )
end

function CanAccessBOBChainChomp()
    return (
        (HasMoves("GP")) or
        (StrictMovementAccessibilityLevel())
    )
end

function CanAccessBOBCoins()
    return (
        (HasCannon(course) and HasCap("WC")) or
        (HasMoves("TJ") and HasCap("WC") and StrictCannonAccessibilityLevel())
    )
end
