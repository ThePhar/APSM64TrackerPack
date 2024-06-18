local course = "TTM"

function CanAccessTTMTop()
    return GetAccessibility({
        (HasMoves("TJ") and StrictMovementAccessibilityLevel()),
        (HasMoves("LJ/DV") and HasMoves("LG/KK")),
        (HasMoves("WK") and HasMoves("SF/LG") and StrictMovementAccessibilityLevel()),
        (HasMoves("KK/DV") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessTTMMushroom()
    return GetAccessibility({
        (HasCannon(course)),
        (HasMoves("LJ") and StrictCannonAccessibilityLevel()),
        (math.min(StrictMovementAccessibilityLevel(), StrictCannonAccessibilityLevel())),
    })
end
