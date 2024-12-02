# Common scripts for Advent of Code

using CSV, DataFrames

# Read a standard CSV file
function aoc_read_csv(filename)
    location_ids = CSV.read(filename, DataFrame, header=false, delim=' ', ignorerepeated=true)
    return location_ids
end

# Read all line of a text file into an array of strings
function aoc_read_lines(filename)
    lines = readlines(filename)
    return lines
end

# Split a string into an array of integers
function aoc_split_integers(line)
    return [parse(Int, x) for x in split(line)]
end
