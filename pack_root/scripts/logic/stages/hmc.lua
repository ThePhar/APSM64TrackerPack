function CanAccessHMCRedCoins()
	return (
	    (HasMoves("CL") and HasMoves("WK/LG/BF/SF/TJ")) or
	    (HasMoves("WK") and StrictMovementAccessibilityLevel())
	)
end

function CanAccessHMCPitIslands()
    return (
        (HasAllMoves("TJ/CL")) or
        (HasMoves("WK") and HasMoves("TJ/LJ") and StrictMovementAccessibilityLevel()) or
        (HasAllMoves("WK/SF/LG") and StrictMovementAccessibilityLevel())
    )
end

function CanAccessMetalHead()
    return (
        (HasMoves("LJ") and HasCap("MC")) or
        (HasAllMoves("LJ/TJ") and StrictCapAccessibilityLevel()) or
        (HasMoves("LJ/TJ/WK") and math.min(StrictCapAccessibilityLevel(), StrictMovementAccessibilityLevel()))
    )
end
