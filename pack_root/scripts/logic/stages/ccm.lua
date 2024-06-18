local course = "CCM"

function CanAccessCCMWalLKicks()
    return (
        (HasCannon(course) and HasMoves("TJ/WK")) or
        (HasMoves("TJ/WK") and StrictCannonAccessibilityLevel()) or
        (StrictMovementAccessibilityLevel())
    )
end
