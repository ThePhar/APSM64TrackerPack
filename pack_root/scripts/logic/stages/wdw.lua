local course = "WDW"

function CanAccessWDWTop()
	return GetAccessibility({
	    (HasMoves("WK/TJ/SF/BF")),
	    (StrictMovementAccessibilityLevel()),
	})
end

function CanAccessWDWDowntown()
    return GetAccessibility({
        (IsNoAreaRando() and HasMoves("LG") and HasMoves("TJ/SF/BF")),
        (HasCannon(course)),
        (HasAllMoves("TJ/DV") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessWDWRedCoins()
    return GetAccessibility({
        (HasMoves("WK")),
        (HasMoves("TJ") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessWDWQuickRace()
    return GetAccessibility({
        (HasCap("VC") and HasMoves("WK/BF")),
        (HasCap("VC") and HasAllMoves("TJ/LG")),
        (HasCap("VC") and HasMoves("TJ") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessWDWBuddy()
    return GetAccessibility({
        (HasMoves("TJ")),
        (HasAllMoves("SF/LG")),
        (IsNoAreaRando() and HasMoves("BF/SF")),
    })
end

function CanAccessWDWCoins()
    return GetAccessibility({
        (HasMoves("GP")),
        (CanAccessWDWDowntown()),
    })
end
