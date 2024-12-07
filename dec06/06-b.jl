using ProgressMeter

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

# keep a backup of the original map
original_map = deepcopy(map)

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

possible_locations = deepcopy(map)

aoc_show_map(map)

println("Number of visited cells = ", visited_cells)

p = Progress(visited_cells; dt=1.0, barglyphs=BarGlyphs("[=> ]"), barlen=50, color=:yellow)

# the following is very inefficient and re-starts the route each time
# would be much better to keep the trail and see what happens next when a new obstacle is added at the next point
# however, it might take me longer than 30 minute to improve the code which is how long it takes to run...

# any one of these visited cells, except the starting one, is a possible location for an additional object
n_loops = 0
n_trials = 0
for i in range(1, rows)
    for j in range(1, cols)
        if possible_locations[i, j] == '*' && original_map[i, j] == '.'
            # println("Trying row = ", i, " column = ", j)
            n_trials += 1
            update!(p, n_trials)
            map = deepcopy(original_map)
            coord = find_symbol(map, '^')
            direction = (-1, 0)
            map[i, j] = '#'
            path = []
            looped = false
            ok = true
            # test to see if this map results in an infinite loop
            while ok
                # mark current position
                map[coord[1], coord[2]] = '*'
                # see if we've looped
                if (coord[1], coord[2], direction[1], direction[2]) ∈ path
                    looped = true
                    ok = false
                    break
                end
                push!(path, (coord[1], coord[2], direction[1], direction[2]))

                new_coord = deepcopy(coord)
                new_coord = new_coord .+ direction
                if new_coord[1] < 1 || new_coord[1] > rows || new_coord[2] < 1 || new_coord[2] > cols
                    # left map
                    ok = false
                    break
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
            if looped
                n_loops += 1
                # aoc_show_map(map)
            end
        end
    end
end

println("Number of loops = ", n_loops)
