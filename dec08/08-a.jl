using Combinatorics

include("../scripts/common.jl")

# map = aoc_read_map("dec08/08-example.txt")
map = aoc_read_map("dec08/08-input.txt")

aoc_show_map(map)

n_rows = size(map, 1)
n_cols = size(map, 2)
antinodes = fill('.', size(map))
antennae = Dict()
for row in 1:n_rows
    for col in 1:n_cols
        cell = map[row, col]
        if cell != '.'
            if haskey(antennae, cell)
                push!(antennae[cell], (row, col))
            else
                antennae[cell] = [(row, col)]
            end
        end
    end
end

for (key, positions) in antennae
    println("Antenna ", key, " is at positions: ", positions)
    for perm in permutations(antennae[key], 2)
        antinode_row = 2*perm[1][1] - perm[2][1]
        antinode_col = 2*perm[1][2] - perm[2][2]
        if antinode_row > 0 && antinode_row <= n_rows && antinode_col > 0 && antinode_col <= n_cols
            antinodes[antinode_row, antinode_col] = '#'
        end
    end
end

aoc_show_map(antinodes)

count_hashes = count(x -> x == '#', antinodes)
println("Number of '#' in antinodes: ", count_hashes)
