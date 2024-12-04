include("../scripts/common.jl")

# grid = aoc_read_block("dec04/04-example-a.txt")
grid = aoc_read_block("dec04/04-input.txt")

n_rows = length(grid)
n_cols = length(grid[1])

# what are we looking for?
# now string has to have an odd number of characters for the code to work
search_string = "MAS"
search_length = length(search_string)

n_found = 0
for r in range(1, n_rows)
    for c in range(1, n_cols)
        mas_found = 0
        for Δr in [-1, 1]
            for Δc in [-1, 1]
                ok = true
                for ix in range(-div(search_length-1,2), div(search_length-1, 2))
                    check_r = r + ix * Δr
                    check_c = c + ix * Δc
                    if check_r >= 1 && check_r <= n_rows && check_c >= 1 && check_c <= n_cols
                        if grid[check_r][check_c] != search_string[1 + div(search_length-1, 2) + ix]
                            ok = false
                        end
                    else
                        ok = false
                    end
                end
                if ok
                    mas_found += 1
                end
            end
        end
        if mas_found == 2
            n_found += 1
        end
    end
end

println("Found $n_found occurrences of X-$search_string")
