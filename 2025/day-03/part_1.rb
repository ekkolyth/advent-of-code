# frozen_string_literal: true

File.foreach('input.txt') do |line|
    idx = line.chars.map.with_index do |char, index|
        { digit: char.to_i, index: index}
end

    high = idx.
        sort_by { |item| item[:digit] }.
        first(2)
