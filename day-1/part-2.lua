local trim = "^%s*(.-)%s*$"

local function get_total_crosses(start_idx, direction, value)
    if value <= 0 then
        return 0
    end

    local distance

    if direction == "R" then
        distance = (100 - start_idx) % 100
        if distance == 0 then
            distance = 100
        end
    elseif direction == "L" then
        distance = start_idx % 100
        if distance == 0 then
            distance = 100
        end
    else
        error("Unexpected direction: " .. tostring(direction))
    end

    if value < distance then
        return 0
    end

    return 1 + math.floor((value - distance) / 100)
end

local function get_password(file_path)
    local file = assert(io.open(file_path, "r"))
    local idx = 50
    local count = 0

    for line in file:lines() do
        line = line:match(trim)

        local first_char = line:match("^%w")
        local value = tonumber(line:sub(2))

        if first_char ~= "R" and first_char ~= "L" then
            error("Unexpected direction: " .. tostring(first_char))
        end

        count = count + get_total_crosses(idx, first_char, value)

        if first_char == "R" then
            idx = idx + value
            elseif first_char == "L" then
            idx = idx - value
            else
                error("Unexpected direction: " .. tostring(first_char))
        end

        idx = idx % 100
    end

    file:close()
    return count
end

local total = get_password("input.txt")
print(total)
