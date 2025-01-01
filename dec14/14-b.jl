include("../scripts/common.jl")

# filename = "dec14/14-example.txt"
filename = "dec14/14-input.txt"

robots = aoc_read_lines(filename)

# width = 7
width = 101
# height = 11
height = 103

robot_states = []
for robot_info in robots
    parts = split(robot_info, r"[ ,=]")
    x = parse(Int, parts[2])
    y = parse(Int, parts[3])
    Δx = parse(Int, parts[5])
    Δy = parse(Int, parts[6])
    push!(robot_states, (x, y, Δx, Δy))
end

best_cf = 0

for moves in 1:10000
    sym = zeros(Int, height)
    robot_map = fill('.', width, height)
    for i in 1:length(robot_states)
        robot_states[i] = ((robot_states[i][1] + robot_states[i][3] + width) % width, (robot_states[i][2] + robot_states[i][4] + height) % height, robot_states[i][3], robot_states[i][4])
        robot_map[robot_states[i][1] + 1, robot_states[i][2] + 1] = '*'
    end
    # aoc_show_map(robot_map)

    # let's look for some measure of correlation across the map
    # begin by looking at what fraction of robots have nearby neighbours
    cf = 0
    for x in 1:width
        for y in 1:height
            if robot_map[x, y] == '*'
                for Δx in -1:1
                    for Δy in -1:1
                        if Δx != 0 && Δy != 0
                            if robot_map[(x + Δx + width) % width + 1, (y + Δy + height) % height + 1] == '*'
                                cf += 1
                            end
                        end
                    end
                end
            end
        end
    end
    if cf > best_cf
        best_cf = cf
        println("Best correlation so far = ", best_cf, " after ", moves, " moves")
        aoc_show_map(robot_map)
    end
end
