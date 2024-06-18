local course = "BOB"

function CanAccessBOBIsland()
    return (
        (HasCannon(course) and AccessibilityLevel.Normal) or
        (HasAllMoves("WC/TJ") and StrictCannonAccessibilityLevel()) or
        (HasMoves("TJ") and math.min(StrictCannonAccessibilityLevel(), StrictMovementAccessibilityLevel()))
    )
end

function CanAccessBOBWings()
    return (
        (HasCannon(course) and HasMoves("WC") and AccessibilityLevel.Normal) or
        (math.min(StrictCannonAccessibilityLevel(), StrictCapAccessibilityLevel()))
    )
end

function CanAccessBOBChainChomp()
    return (
        (HasMoves("GP") and AccessibilityLevel.Normal) or
        (StrictMovementAccessibilityLevel())
    )
end

function CanAccessBOBCoins()
    return (
        (HasCannon(course) and HasMoves("WC") and AccessibilityLevel.Normal) or
        (HasAllMoves("WC/TJ") and StrictCannonAccessibilityLevel())
    )
end
