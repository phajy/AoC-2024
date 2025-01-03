include("../scripts/common.jl")

# read in the problem
begin
    # maze = aoc_read_map("dec16/16-example.txt")
    maze = aoc_read_map("dec16/16-input.txt")
    # maze = aoc_read_map("dec16/day16-1.txt")
    # aoc_show_map(maze)
    y_size = size(maze, 1)
    x_size = size(maze, 2)
end

# initialise the array of costs and find the starting position
begin
    dir = Dict("right" => 1, "up" => 2, "left" => 3, "down" => 4)
    # steps have Δy and Δx in same order as directions above
    steps = [[0, 1], [-1, 0], [0, -1], [1, 0]]
    cost_map = fill(typemax(Int), (y_size, x_size, 4))
    best_cost = typemax(Int)
    start_x = -1
    start_y = -1
    for y in 1:y_size
        for x in 1:x_size
            if maze[y, x] == 'S'
                start_x = x
                start_y = y
            end
        end
    end
end

function turn(dir, dir_change)
    # direction change: -1 = right, +1 = left
    dir += dir_change
    if dir > 4
        dir = 1
    end
    if dir < 1
        dir = 4
    end
    return dir
end

struct State
    y::Int
    x::Int
    dir::Int
    cost::Int
end

# record current position and check the next step
function next_step(cur_pos)
    global best_cost
    # see if we're currently at a better position than we have been in the past
    if cur_pos.cost < cost_map[cur_pos.y, cur_pos.x, cur_pos.dir]
        cost_map[cur_pos.y, cur_pos.x, cur_pos.dir] = cur_pos.cost
        # check we're not already at the end
        if maze[cur_pos.y, cur_pos.x] == 'E'
            if cur_pos.cost < best_cost
                println("Found a solution with cost ", cur_pos.cost)
                best_cost = cur_pos.cost
            end
        else
            # now take a step forward
            for action in 1:3
                if action == 1
                    # move forward
                    new_y = cur_pos.y + steps[cur_pos.dir][1]
                    new_x = cur_pos.x + steps[cur_pos.dir][2]
                    new_dir = cur_pos.dir
                    new_cost = cur_pos.cost + 1
                end
                if action == 2 || action == 3
                    # turn left or right
                    new_y = cur_pos.y
                    new_x = cur_pos.x
                    new_dir = turn(cur_pos.dir, 2 * action - 5)
                    new_cost = cur_pos.cost + 1000
                end
                if (new_x > 0 && new_x <= x_size && new_y > 0 && new_y <= y_size)
                    if maze[new_y, new_x] != '#'
                        # println("Moving to ", new_y, ", ", new_x, " with cost ", new_cost)
                        if new_cost < best_cost
                            next_pos = State(new_y, new_x, new_dir, new_cost)
                            next_step(next_pos)
                        end
                    end
                end
            end
        end
    end
end

cur_pos = State(start_y, start_x, dir["right"], 0)
begin
    t1 = time()
    next_step(cur_pos)
    print(time() - t1, " seconds to find the solution\n")
end
