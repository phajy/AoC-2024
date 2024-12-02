include("../scripts/common.jl")

# filename = "dec02/02-example.txt"
filename = "dec02/02-input.txt"

reactor_reports = aoc_read_lines(filename)

n_safe = 0
for report in reactor_reports
    # check to see if any combinations are safe
    any_safe = false
    levels = aoc_split_integers(report)
    for i in 0:length(levels)
        check_levels = levels[1:end .!= i]
        Δ = diff(check_levels)
        if (all(x -> x > 0, Δ) || all(x -> x < 0, Δ)) && (maximum(abs.(Δ)) <= 3) && (minimum(abs.(Δ)) >= 1)
            any_safe = true
        end
    end
    if (any_safe)
        n_safe = n_safe + 1
    end
end

println(n_safe, " reports are safe")
