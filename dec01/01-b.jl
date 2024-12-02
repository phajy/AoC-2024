include("../scripts/common.jl")

filename = "dec01/01-example.txt"
# filename = "dec01/01-input.txt"

location_ids = aoc_read_csv(filename)

first_list = location_ids[:, 1]
second_list = location_ids[:, 2]

similarity = 0
for element in first_list
    n = count(x -> x == element, second_list)
    similarity += element * n
end

println("Similarity: ", similarity)
