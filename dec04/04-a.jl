include("../scripts/common.jl")

# grid = aoc_read_block("dec04/04-example-a.txt")
grid = aoc_read_block("dec04/04-input.txt")

n_rows = length(grid)
n_cols = length(grid[1])

# what are we looking for?
search_string = "XMAS"
search_length = length(search_string)

n_found = 0
# loop through each starting point
for r in range(1, n_rows)
    for c in range(1, n_cols)
        # see if we find a match looking in all directions
        for Δr in [-1, 0, 1]
            for Δc in [-1, 0, 1]
                if !(Δr ==0 && Δc == 0)
                    # println("Checking $r, $c, $Δr, $Δc")
                    ok = true
                    for ix in range(1, search_length)
                        check_r = r + (ix-1)*Δr
                        check_c = c + (ix-1)*Δc
                        if check_r >= 1 && check_r <= n_rows && check_c >= 1 && check_c <= n_cols
                            if grid[check_r][check_c] != search_string[ix]
                                ok = false
                            end
                        else
                            ok = false
                        end
                    end
                    if ok
                        println("Found starting at $r, $c")
                        n_found += 1
                    end
                end
            end
        end
    end
end

println("Found $n_found occurrences of $search_string")
