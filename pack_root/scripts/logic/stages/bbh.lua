function CanAccessBBHThirdFloor()
    return GetAccessibility({
        (HasAllMoves("WK/LG")),
        (HasMoves("WK") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessBBHRoof()
    return GetAccessibility({
        (HasMoves("LG")),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessBBHBooks()
    return GetAccessibility({
        (HasMoves("KK")),
        (StrictMovementAccessibilityLevel()),
    })
end
