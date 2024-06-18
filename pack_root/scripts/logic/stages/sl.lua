function CanAccessSLIgloo()
	return GetAccessibility({
	    (HasCap("VC") and HasMoves("TJ/SF/BF/WK/LG")),
	    (HasCap("VC") and StrictMovementAccessibilityLevel()),
	})
end

function CanAccessSLCoins()
    return GetAccessibility({
        (HasCap("VC")),
        (StrictCapAccessibilityLevel()),
    })
end
