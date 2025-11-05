local TableUtils = {}

function TableUtils.getIndex(tbl, value)
	for i, v in ipairs(tbl) do
		if v == value then
			return i
		end
	end
	return nil -- если не нашли
end

function TableUtils.removeByValue(tbl, value)
	local index = TableUtils.getIndex(tbl, value)
	if index then
		table.remove(tbl, index)
	end
end

return TableUtils
