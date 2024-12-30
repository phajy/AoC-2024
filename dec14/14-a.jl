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

for moves in 1:100
    for i in 1:length(robot_states)
        robot_states[i] = ((robot_states[i][1] + robot_states[i][3] + width) % width, (robot_states[i][2] + robot_states[i][4] + height) % height, robot_states[i][3], robot_states[i][4])
    end
end

quad_tot = [ [0, 0], [0, 0] ]
mid_x = (width-1) / 2
mid_y = (height-1) / 2
for i in 1:length(robot_states)
    x, y, Δx, Δy = robot_states[i]
    x_ix = -1
    y_ix = -1
    if x < mid_x
        x_ix = 1
    end
    if x > mid_x
        x_ix = 2
    end
    if y < mid_y
        y_ix = 1
    end
    if y > mid_y
        y_ix = 2
    end
    if x_ix != -1 && y_ix != -1
        quad_tot[x_ix][y_ix] += 1
    end
end

sf = quad_tot[1][1] * quad_tot[1][2] * quad_tot[2][1] * quad_tot[2][2]

println("Safety factor = ", sf)