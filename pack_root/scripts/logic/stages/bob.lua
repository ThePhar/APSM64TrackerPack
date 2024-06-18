local course = "BOB"

function CanAccessBOBIsland()
    return (
        (HasCannon(course)) or
        (HasAllMoves("WC/TJ") and StrictCannonAccessibilityLevel()) or
        (HasMoves("TJ") and math.min(StrictCannonAccessibilityLevel(), StrictMovementAccessibilityLevel()))
    )
end

function CanAccessBOBWings()
    return (
        (HasCannon(course) and HasMoves("WC")) or
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
        (HasCannon(course) and HasMoves("WC")) or
        (HasAllMoves("WC/TJ") and StrictCannonAccessibilityLevel())
    )
end
