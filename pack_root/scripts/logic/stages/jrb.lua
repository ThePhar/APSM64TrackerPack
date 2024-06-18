local course = "JRB"

function CanAccessJRBShip()
    return (
        (HasMoves("TJ/BF/SF/WK")) or
        (HasMoves("LG") and StrictMovementAccessibilityLevel())
    )
end

function CanAccessJRBRedCoins()
    return (
        (HasCannon(course)) or
        (HasMoves("CL/TJ")) or
        (HasMoves("BF/WK") and StrictMovementAccessibilityLevel())
    )
end

function CanAccessJRBPillar()
    return (
        (HasCannon(course) and HasMoves("CL")) or
        (HasCannon(course) and StrictMovementAccessibilityLevel()) or
        (math.min(StrictMovementAccessibilityLevel(), StrictCannonAccessibilityLevel()))
    )
end

function CanAccessJRBStream()
    return (
        (HasCap("MC")) or
        (StrictCapAccessibilityLevel())
    )
end
