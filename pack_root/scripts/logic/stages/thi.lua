function CanAccessTHIPipes()
    return GetAccessibility({
        (IsNoAreaRando()),
        (HasMoves("LJ/TJ/DV/LG")),
        (HasMoves("BF/SF/KK") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessTHIHugeTop()
    return GetAccessibility({
        (IsNoAreaRando()),
        (HasMoves("LG/TJ/DV")),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessTHIWiggler()
    return GetAccessibility({
        (HasMoves("GP")),
        (HasMoves("DV") and StrictMovementAccessibilityLevel()),
    })
end
