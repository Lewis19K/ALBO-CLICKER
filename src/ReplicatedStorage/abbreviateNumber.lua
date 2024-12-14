local abbreviateNumber = {}

local abbreviations = {
	K = 4,
	M = 7,
	B = 10,
	T = 13,
	Qd = 16,
	Qi = 19
}

function abbreviateNumber:Abbreviate(number)
	if number == nil or number == 0 then
		return "0"
	end

	local text = tostring(math.floor(number))

	local chosenAbbreviation
	for abbreviation, digits in pairs(abbreviations) do
		if #text >= digits and #text < (digits + 3) then
			chosenAbbreviation = abbreviation
			break
		end
	end

	if chosenAbbreviation then
		local digits = abbreviations[chosenAbbreviation]
		local rounded = math.floor(number / 10 ^ (digits - 2) * 10 ^ (digits - 2))
		text = string.format("%.1f", rounded / 10 ^ (digits - 1)) .. chosenAbbreviation
	else
		text = number
	end

	return text
end

return abbreviateNumber
