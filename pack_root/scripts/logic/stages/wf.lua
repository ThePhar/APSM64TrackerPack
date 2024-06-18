local course = "WF"

function CanAccessWFTower()
    return HasMoves("GP")
end

function CanAccessWFWildBlue()
    return (
        (HasMoves("WK") and HasMoves("TJ/SF")) or
        (HasCannon(course))
    )
end

function CanAccessWFCagedIsland()
    return (
        (CanAccessWFTower() and HasMoves("CL")) or
        (HasMoves("TJ") and StrictMovementAccessibilityLevel()) or
        (HasMoves("LJ") and StrictMovementAccessibilityLevel()) or
        (HasCannon(course) and StrictMovementAccessibilityLevel())
    )
end

function CanAccessWFWall()
    return (
        (HasCannon(course)) or
        (HasMoves("LG") and StrictCannonAccessibilityLevel())
    )
end

function CanAccessWFCoins()
    return (
        (HasMoves("GP")) or
        (StrictMovementAccessibilityLevel())
    )
end
