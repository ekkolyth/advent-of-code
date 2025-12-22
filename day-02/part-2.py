import re as regex

results = []

with open("input.txt", "r") as file:
    raw = file.read()
    items = raw.split(",")

    for item in items:
        range_start, range_end = item.split("-")
        results.append((range_start, range_end))


def get_range(results):
    range_list = []

    for start, end in results:
        start = int(start)
        end = int(end.strip())
        range_list.append([start, end + 1])
    return range_list


def expand_ranges(range_list):
    expanded = []

    for start, end in range_list:
        expanded.append(list(range(start, end)))
    return expanded


def has_pattern(number):
    pattern = regex.search(r"^(\d+)\1+$", str(number))
    return pattern is not None

expanded = expand_ranges(get_range(results))

invalid_ids = []

for row in expanded:
    for number in row:
        if has_pattern(number):
            invalid_ids.append(number)

def get_total(id):
    total = sum(id)
    return total


print(get_total(invalid_ids))
# print(invalid_ids)
