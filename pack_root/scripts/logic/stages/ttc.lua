function CanAccessTTCLower()
	return HasMoves("LG/TJ/SF/BF/WK")
end

function CanAccessTTCUpper()
    local lower_access = CanAccessTTCLower()
    if not lower_access then
    	return AccessibilityLevel.None
    end

    return GetAccessibility({
        (HasMoves("CL")),
        (HasMoves("WK") and StrictMovementAccessibilityLevel()),
    })
end

function CanAccessTTCTop()
    local upper_access = CanAccessTTCUpper()
    if upper_access == AccessibilityLevel.None then
    	return upper_access
    end

    local top_access = GetAccessibility({
        (HasAllMoves("TJ/LG")),
        (HasMoves("WK/TJ") and StrictMovementAccessibilityLevel()),
    })

    if upper_access == AccessibilityLevel.SequenceBreak and top_access == AccessibilityLevel.Normal then
    	return AccessibilityLevel.SequenceBreak
    elseif upper_access == AccessibilityLevel.Normal then
        return top_access
    end
end
