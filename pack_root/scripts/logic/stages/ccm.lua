local course = "CCM"

function CanAccessCCMWallKicks()
    return GetAccessibility({
        (HasCannon(course) and HasMoves("TJ/WK")),
        (HasMoves("TJ/WK") and StrictCannonAccessibilityLevel()),
        (StrictMovementAccessibilityLevel()),
    })
end
