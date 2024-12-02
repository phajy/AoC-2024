# Common scripts for Advent of Code

using CSV, DataFrames

# Read a standard CSV file
function aoc_read_csv(filename)
    location_ids = CSV.read(filename, DataFrame, header=false, delim=' ', ignorerepeated=true)
    return location_ids
end
