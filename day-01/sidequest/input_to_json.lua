
-- read input file and open output file
local input_path = arg[1]
local output_path = arg[2]
local input_file = io.open(input_path, "r")
local output_file = io.open(output_path, "w")

if not input_file then
    io.stderr:write("Error: Could not open input file: " .. input_path .. "\n")
    os.exit(1)
end

if not output_file then
    io.stderr:write("Error: Could not open output file for writing: " .. output_path .. "\n")
    input_file:close()
    os.exit(1)
end

-- track current position in json file
local current_id = 1
local is_first_item = true

-- output json array, truncate existing data and write input data to file
output_file:write("[\n")
for line in input_file:lines() do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed ~= "" then
    -- write a comma before the item only if this is not the first time
    if not is_first_item then
        output_file:write(",\n")
    end
    output_file:write(
        string.format('{\n"id": %d,\n"value": "%s"\n }', current_id, trimmed)
    )
    is_first_item = false
    current_id = current_id + 1
    end
end

output_file:write("\n]\n")
