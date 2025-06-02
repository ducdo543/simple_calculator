local utils = {}

function utils.copy_table(table)
    local copy = {}
    for i, value in pairs(table) do
        copy[i] = value
    end
    return copy
end

return utils