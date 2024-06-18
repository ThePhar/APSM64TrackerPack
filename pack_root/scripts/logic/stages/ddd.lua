function CanAccessDDDRedCoins()
    return GetAccessibility({
        (HasMoves("CL") and HasCompleted("3626179")),
        (HasAllMoves("TJ/DV/LG/WK") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessDDDStream()
    return GetAccessibility({
        (HasCap("MC")),
        (StrictCapAccessibilityLevel()),
    })
end

function CanAccessDDDCaps()
    return GetAccessibility({
        (HasCap("MC") and HasCap("VC")),
        (HasCap("VC") and StrictCapAccessibilityLevel()),
    })
end
