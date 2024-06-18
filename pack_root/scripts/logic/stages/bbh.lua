function CanAccessBBHThirdFloor()
    return (
        (HasAllMoves("WK/LG")) or
        (HasMoves("WK") and StrictMovementAccessibilityLevel())
    )
end

function CanAccessBBHRoof()
    return (
        (HasMoves("LG")) or
        (StrictMovementAccessibilityLevel())
    )
end

function CanAccessBBHBooks()
    return (
        (HasMoves("KK")) or
        (StrictMovementAccessibilityLevel())
    )
end
