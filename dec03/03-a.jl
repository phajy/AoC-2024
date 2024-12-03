include("../scripts/common.jl")

# filename = "dec03/03-example.txt"
filename = "dec03/03-input.txt"

instruction_lines = aoc_read_lines(filename)

total = 0
for instruction in instruction_lines
    for m in eachmatch(r"mul\(([0-9]|[0-9][0-9]|[0-9][0-9][0-9]),([0-9]|[0-9][0-9]|[0-9][0-9][0-9])\)", instruction)
        total = total + parse(Int, m[1]) * parse(Int, m[2])
    end
end

println("Total = ", total)
