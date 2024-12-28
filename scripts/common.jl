# Common scripts for Advent of Code

using CSV, DataFrames
using Crayons, Crayons.Box

# Read a standard CSV file
function aoc_read_csv(filename, delim::Char = ' ')
    location_ids = CSV.read(filename, DataFrame, header=false, delim=delim, ignorerepeated=true)
    return location_ids
end

# Read all line of a text file into an array of strings
function aoc_read_lines(filename)
    lines = readlines(filename)
    return lines
end

# Read a 2D block of text into a 2D array of characters
function aoc_read_block(filename)
    lines = aoc_read_lines(filename)
    grid = [collect(x) for x in lines]
    return grid
end

# Split a string into an array of integers
function aoc_split_integers(line)
    return [parse(Int, x) for x in split(line)]
end

# Read in a map
function aoc_read_map(filename)
    lines = aoc_read_lines(filename)
    cols = length(lines)
    rows = length(lines[1])
    map = Array{Char}(undef, cols, rows)
    for i in 1:cols
        for j in 1:rows
            map[i, j] = lines[i][j]
        end
    end
    return map
end

# Make a nice 2D plot of the map
function aoc_show_map(map)
    rows = size(map, 1)
    cols = size(map, 2)
    
    # Define colors
    blue = Crayon(foreground=:blue)
    red = Crayon(foreground=:red)
    
    # Top border
    print(RED_FG, CYAN_BG, "┌" * "─"^cols * "┐")
    println(DEFAULT_FG, DEFAULT_BG)
    
    # Map content with side borders
    for row in 1:rows
        print(RED_FG, CYAN_BG, "│")
        for col in 1:cols
            char = map[row, col]
            if char == '#'
                print(BLUE_FG, DEFAULT_BG, char)
            elseif char == '^'
                print(RED_FG, DEFAULT_BG, char)
            elseif char == '*'
                print(GREEN_FG, YELLOW_BG, char)
            else
                print(DEFAULT_FG, DEFAULT_BG, char)
            end
        end
        print(RED_FG, CYAN_BG, "│")
        println(DEFAULT_BG)
    end
    
    # Bottom border
    print(RED_FG, CYAN_BG, "└" * "─"^cols * "┘")
    println(DEFAULT_FG, DEFAULT_BG)
end
