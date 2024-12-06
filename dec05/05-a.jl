include("../scripts/common.jl")

# safety_updates = aoc_read_lines("dec05/05-example-a.txt")
safety_updates = aoc_read_lines("dec05/05-input.txt")

total = 0
order = []
for line in safety_updates
    # see if we have an ordering or a list of pages
    if '|' in line
        parts = split(line, "|")
        push!(order, [parts[1], parts[2]])
    else
        if line != ""
            pages = split(line, ",")
            ok = true
            for check in order
                i1 = findfirst(x -> x == check[1], pages)
                i2 = findfirst(x -> x == check[2], pages)
                if i1 != nothing && i2 != nothing
                    if i1 > i2
                        ok = false
                    end
                end
            end
            if ok
                total += parse(Int, pages[div(length(pages)+1,2)])
            end
        end
    end
end

println("Total = ", total)
