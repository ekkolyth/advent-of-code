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
        else
            idx = idx - value
        end

            if idx < 0 then
                idx = idx % 100
            end

            if idx > 99 then
                idx = idx % 100
            end

            if idx == 0 then
                table.insert(result, line)
            end
        end

    file:close()
    return result
end

local rows = get_password("input.txt")
print(#rows)
