include("../scripts/common.jl")

# incoming_list = aoc_read_csv("dec18/18-example.txt", ',')
incoming_list = aoc_read_csv("dec18/18-input.txt", ',')
max_incoming_len = size(incoming_list, 1)

mem_size = 71
incoming_len = 1024
possible = true

while possible
    incoming_len += 1
    mem_map = fill('.', mem_size, mem_size)

    for row in range(1, incoming_len)
        x = incoming_list[row, 1]
        y = incoming_list[row, 2]
        mem_map[y+1, x+1] = '#'
    end

    # aoc_show_map(mem_map)

    paths = [[(1, 1)]]
    done = false
    count = 1

    while !done && count < 5500
        count += 1
        new_paths = []
        for path in paths
            last_x = (path[end])[1]
            last_y = (path[end])[2]
            # println("Path ", path, " end at ", last_x, ", ", last_y)
            if (last_x == mem_size && last_y == mem_size)
                # println("Found optimal path of length ", length(path)-1)
                done = true
                break
            end
            mem_map[last_x, last_y] = 'O'
            # aoc_show_map(mem_map)
            for (Δx, Δy) in ((1,0), (-1,0), (0,1), (0,-1))
                next_x = last_x + Δx
                next_y = last_y + Δy
                if (next_x >= 1 && next_x <= mem_size && next_y >= 1 && next_y <= mem_size)
                    if mem_map[next_x, next_y] == '.'
                        new_path = copy(path)
                        push!(new_path, (next_x, next_y))
                        push!(new_paths, new_path)
                    end
                    mem_map[next_x, next_y] = 'O'
                end
            end
        end
        paths = copy(new_paths)
    end

    if !done
        possible = false
        println(incoming_len, " is not possible")
        println("The problem coordinate is ", incoming_list[incoming_len,:])
        break
    else
        println(incoming_len, " is possible")
    end
end
