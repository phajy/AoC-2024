include("../scripts/common.jl")

# map = aoc_read_map("dec06/06-example-a.txt")
map = aoc_read_map("dec06/06-input.txt")

aoc_show_map(map)

function find_symbol(map, symbol)
    rows = size(map, 1)
    cols = size(map, 2)
    for i in range(1, rows)
        for j in range(1, cols)
            if map[i, j] == symbol
                return (i, j)
            end
        end
    end
    return nothing
end

rows = size(map, 1)
cols = size(map, 2)
coord = find_symbol(map, '^')
direction = (-1, 0)
visited_cells = 0
ok = true

while ok
    # mark current position
    if map[coord[1], coord[2]] != '*'
        visited_cells += 1
    end
    map[coord[1], coord[2]] = '*'
    new_coord = deepcopy(coord)
    new_coord = new_coord .+ direction
    if new_coord[1] < 1 || new_coord[1] > rows || new_coord[2] < 1 || new_coord[2] > cols
        # left map
        ok = false
    else
        if map[new_coord[1], new_coord[2]] != '#'
            # it is OK to move
            coord = new_coord
        else
            # we've bumped into something and need to turn right
            if direction == (-1, 0)
                direction = (0, 1)
            elseif direction == (0, 1)
                direction = (1, 0)
            elseif direction == (1, 0)
                direction = (0, -1)
            elseif direction == (0, -1)
                direction = (-1, 0)
            end
        end
    end
end

aoc_show_map(map)

println("Number of visited cells = ", visited_cells)
