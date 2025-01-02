# 2025-01-02 completely redesign the logic which wasn't working on the full case anyway!

include("../scripts/common.jl")

begin
    maze = aoc_read_map("dec16/16-example.txt")
    # maze = aoc_read_map("dec16/16-input.txt")
    # maze = aoc_read_map("dec16/day16-1.txt")
    # aoc_show_map(maze)
    y_size = size(maze, 1)
    x_size = size(maze, 2)
end

begin
    end_x = -1
    end_y = -1
    for y in 1:y_size
        for x in 1:x_size
            if maze[y, x] == 'S'
                # push x and y coordinate and "east" direction
                push!(paths, [[x, y, 1, 0]])
                push!(costs, 0)
                maze[y, x] = '.'
            end
            if maze[y, x] == 'E'
                end_x = x
                end_y = y
                maze[y, x] = '.'
            end
        end
    end
end

function calc_rotation(Δx, Δy, rotation)
    # rotation = 2 - turn left
    # rotation = 3 - turn right
    if rotation == 2
        # 90 degree turn left
        M = [0 1; -1 0]
    elseif rotation == 3
        # 90 degree turn right
        M = [0 -1; 1 0]
    end
    new_direction = M * [Δx; Δy]
    # println("rotation = ", rotation, " Δx = ", Δx, " Δy = ", Δy, " new_direction = ", new_direction)
    return (new_direction[1], new_direction[2])
end

# calculate all possible next states
# move in the direction of the current state or rotate left / right
best_cost = -1
c = 1
# maximum allowable cost - those that exceed this cost are put in a holding pattern
max_cost = 100000
while length(paths) > 0 && c < 5000
    c += 1
    n_holding = 0
    new_paths = []
    new_costs = []
    min_dist = 2 * x_size * y_size
    # println("Checking out ", length(paths), " paths")
    for ix in 1:length(paths)
        # println("Checking individual path ", paths[ix])
        cur_position = paths[ix][end]
        # println("  with current position ", cur_position)
        # see if we've found a solution
        cur_dist = sqrt((cur_position[1] - end_x)^2 + (cur_position[2] - end_y)^2)
        if cur_dist < min_dist
            min_dist = cur_dist
        end
        if cur_position[1] == end_x && cur_position[2] == end_y
            println("Found solution with cost ", costs[ix])
            if costs[ix] < best_cost || best_cost < 0
                best_cost = costs[ix]
                println("  and this is the best so far!")
            end
        else
            if costs[ix] < max_cost
                for trial in 1:3
                    path = deepcopy(paths[ix])
                    cost = costs[ix]
                    # println("Extending path ", path, " with current cost ", cost)
                    if trial == 1
                        # move forward
                        # println("trying to move forward")
                        new_position = [cur_position[1] + cur_position[3], cur_position[2] + cur_position[4], cur_position[3], cur_position[4]]
                        cost = cost + 1
                    else
                        # rotate left or right
                        # println("trying to rotate")
                        new_direction = calc_rotation(cur_position[3], cur_position[4], trial)
                        new_position = [cur_position[1], cur_position[2], new_direction[1], new_direction[2]]
                        cost = cost + 1000
                    end
                    # println("trying ", new_position)
                    if maze[new_position[2], new_position[1]] != '#'
                        # have we been in this state before with a lower cost?
                        ok = true
                        # println("checking if ", new_position, " is in ", new_paths)
                        for j in 1:length(paths)
                            # println("  specific check ", new_position, " with ", new_paths[j])
                            if new_position ∈ paths[j]
                                ok = false
                                # println("bad!")
                                break
                            end
                        end
                        if ok
                            # println("Adding new position ", new_position, " with cost ", cost)
                            # println("  to path ", path)
                            if (best_cost > 0 && cost < best_cost) || best_cost < 0
                                push!(path, new_position)
                                push!(new_paths, path)
                                push!(new_costs, cost)
                            end
                        end
                    end
                end
            else
                # too expensive to pursue so put into holding pattern for now
                path = deepcopy(paths[ix])
                cost = costs[ix]
                push!(new_paths, path)
                push!(new_costs, cost)
                n_holding += 1
            end
        end
    end
    paths = deepcopy(new_paths)
    costs = deepcopy(new_costs)
    println("Distance to end ", min_dist, " checking ", length(paths), " paths and holding ", n_holding)
    if (length(paths) == n_holding)
        max_cost += 1000
        println("Relaxing cost constraint to ", max_cost)
    end
end

println("Best solution has cost ", best_cost)
