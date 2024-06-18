local course = "CCM"

function CanAccessCCMWalLKicks()
    return ({
        (HasCannon(course) and HasMoves("TJ/WK")),
        (HasMoves("TJ/WK") and StrictCannonAccessibilityLevel()),
        (StrictMovementAccessibilityLevel()),
    })
end
