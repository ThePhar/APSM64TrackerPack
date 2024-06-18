function CanAccessHMCRedCoins()
	return GetAccessibility({
	    (HasMoves("CL") and HasMoves("WK/LG/BF/SF/TJ")),
	    (HasMoves("WK") and StrictMovementAccessibilityLevel()),
	})
end

function CanAccessHMCPitIslands()
    return GetAccessibility({
        (HasAllMoves("TJ/CL")),
        (HasMoves("WK") and HasMoves("TJ/LJ") and StrictMovementAccessibilityLevel()),
        (HasAllMoves("WK/SF/LG") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessMetalHead()
    return GetAccessibility({
        (HasMoves("LJ") and HasCap("MC")),
        (HasAllMoves("LJ/TJ") and StrictCapAccessibilityLevel()),
        (HasMoves("LJ/TJ/WK") and math.min(StrictCapAccessibilityLevel(), StrictMovementAccessibilityLevel())),
    })
end
