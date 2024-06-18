local course = "WF"

function CanAccessWFTower()
    return HasMoves("GP")
end

function CanAccessWFWildBlue()
    return GetAccessibility({
        (HasMoves("WK") and HasMoves("TJ/SF")),
        (HasCannon(course)),
    })
end

function CanAccessWFCagedIsland()
    return GetAccessibility({
        (CanAccessWFTower() and HasMoves("CL")),
        (HasMoves("TJ") and StrictMovementAccessibilityLevel()),
        (HasMoves("LJ") and StrictMovementAccessibilityLevel()),
        (HasCannon(course) and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessWFWall()
    return GetAccessibility({
        (HasCannon(course)),
        (HasMoves("LG") and StrictCannonAccessibilityLevel()),
    })
end

function CanAccessWFCoins()
    return GetAccessibility({
        (HasMoves("GP")),
        (StrictMovementAccessibilityLevel()),
    })
end
