local trim = "^%s*(.-)%s*$"

local function get_password(file_path)
    local file = assert(io.open(file_path, "r"))
    local idx = 50

    local result = {}
    for line in file:lines() do

        local first_char = line:match("^%w")
        local value = tonumber(line:sub(2))

        line = line:match(trim)

        if first_char == "R" then
            idx = idx + value
        elseif first_char == "L" then
            idx = idx - value
            else
                error("Unexpected direction: " .. tostring(first_char))
        end

        idx = idx % 100
            if idx == 0 then
                table.insert(result, line)
            end
        end

    file:close()
    return result
end

local rows = get_password("input.txt")
print(#rows)
