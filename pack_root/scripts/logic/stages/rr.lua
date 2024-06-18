function CanAccessRRMaze()
    return GetAccessibility({
        (HasMoves("WK")),
        (HasMoves("LJ") and HasMoves("SF/BF/TJ")),
        (HasMoves("LG/TJ") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessRRCruiser()
    return GetAccessibility({
        (HasMoves("WK/SF/BF/LG/TJ"))
    })
end

function CanAccessRRHouse()
    return GetAccessibility({
        (HasMoves("TJ/SF/BF/LG"))
    })
end

function CanAccessRRBuddy()
    return GetAccessibility({
        (HasMoves("WK")),
        (HasMoves("LG") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessRRSwinging()
    return GetAccessibility({
        (HasMoves("LG/TJ/BF/SF")),
        (StrictMovementAccessibilityLevel()),
    })
end

function CanAccessRRTriangles()
    return GetAccessibility({
        (HasMoves("LG/TJ/BF/SF")),
        (StrictMovementAccessibilityLevel()),
    })
end
