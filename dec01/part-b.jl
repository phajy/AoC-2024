using CSV, DataFrames

filename = "dec01/example.txt"
# filename = "dec01/input.txt"

location_ids = CSV.read(filename, DataFrame, header=false, delim=' ', ignorerepeated=true)

first_list = location_ids[:, 1]
second_list = location_ids[:, 2]

similarity = 0
for element in first_list
    n = count(x -> x == element, second_list)
    similarity += element * n
end

println("Similarity: ", similarity)
