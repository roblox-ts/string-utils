local StringUtils = {}

function StringUtils.trim(str)
	return string.match(str, "^%s*(.-)%s*$")
end

function StringUtils.trimStart(str)
	return string.match(str, "^%s*(.-)$")
end

function StringUtils.trimEnd(str)
	return string.match(str, "^(.-)%s*$")
end

-- https://github.com/tc39/proposal-string-pad-start-end/blob/master/polyfill.js
local function getPadding(str, maxLength, fillString)
	local stringLength = #str
	if maxLength <= stringLength then return str end
	local filler = fillString == nil and " " or fillString
	if filler == "" then return str end
	local fillLen = maxLength - stringLength
	while filler.length < fillLen do
		local fLen = filler.length
		local remainingCodeUnits = fillLen - fLen
		if fLen > remainingCodeUnits then
			filler = filler .. string.sub(filler, 1, remainingCodeUnits)
		else
			filler = filler .. filler
		end
	end
	return string.sub(filler, 1, fillLen)
end

function StringUtils.padStart(str, maxLength, fillString)
	return getPadding(str, maxLength, fillString) .. str
end

function StringUtils.padEnd(str, maxLength, fillString)
	return str .. getPadding(str, maxLength, fillString)
end

function StringUtils.slice(str, i, j)
	return string.sub(str, i + 1, j)
end

function StringUtils.indexOf(str, searchElement, fromIndex)
	return (string.find(str, searchElement, (fromIndex or 0) + 1, true) or 0) - 1
end

function StringUtils.includes(str, searchElement, fromIndex)
	return string.find(str, searchElement, (fromIndex or 0) + 1, true) ~= nil
end

function StringUtils.startsWith(str1, str2, pos)
	local n1 = #str1
	local n2 = #str2

	if pos == nil or pos ~= pos then
		pos = 0
	else
		pos = math.clamp(pos, 0, n1)
	end

	local last = pos + n2
	return last <= n1 and string.sub(str1, pos + 1, last) == str2
end

function StringUtils.endsWith(str1, str2, pos)
	local n1 = #str1
	local n2 = #str2

	if pos == nil then
		pos = n1
	elseif pos ~= pos then
		pos = 0
	else
		pos = math.clamp(pos, 0, n1)
	end

	local start = pos - n2 + 1
	return start > 0 and string.sub(str1, start, pos) == str2
end

return StringUtils
