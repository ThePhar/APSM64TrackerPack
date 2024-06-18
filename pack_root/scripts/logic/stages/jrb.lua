local course = "JRB"

function CanAccessJRBShip()
    return GetAccessibility({
        (HasMoves("TJ/BF/SF/WK")),
        (HasMoves("LG") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessJRBRedCoins()
    return GetAccessibility({
        (HasCannon(course)),
        (HasMoves("CL/TJ")),
        (HasMoves("BF/WK") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessJRBPillar()
    return GetAccessibility({
        (HasCannon(course) and HasMoves("CL")),
        (HasCannon(course) and StrictMovementAccessibilityLevel()),
        (math.min(StrictMovementAccessibilityLevel(), StrictCannonAccessibilityLevel())),
    })
end

function CanAccessJRBStream()
    return GetAccessibility({
        (HasCap("MC")),
        (StrictCapAccessibilityLevel()),
    })
end
