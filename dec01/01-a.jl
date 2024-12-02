include("../scripts/common.jl")

filename = "dec01/example.txt"
# filename = "dec01/input.txt"

location_ids = aoc_read_csv(filename)

first_list = location_ids[:, 1]
second_list = location_ids[:, 2]

sort!(first_list)
sort!(second_list)

distances = abs.(second_list .- first_list)
total_distance = sum(distances)

println("Total distance: ", total_distance)
