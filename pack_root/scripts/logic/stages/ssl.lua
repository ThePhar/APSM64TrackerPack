local course = "SSL"

function CanAccessSSLUpperPyramid()
    return GetAccessibility({
        (HasMoves("CL") and HasMoves("TJ/BF/SF/LG")),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessSSLPillars()
    return GetAccessibility({
        (HasAllMoves("TJ/GP") and HasCap("WC")),
        (HasMoves("GP") and HasCap("WC") and HasCannon(course)),
        (HasMoves("TJ/SF/BF") and StrictCapAccessibilityLevel()),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessSSLRedCoins()
    return GetAccessibility({
        (HasMoves("TJ") and HasCap("WC")),
        (HasCannon(course) and HasCap("WC")),
        (HasMoves("TJ/SF/BF") and StrictCapAccessibilityLevel()),
        (math.min(StrictCapAccessibilityLevel(), StrictMovementAccessibilityLevel())),
    })
end
