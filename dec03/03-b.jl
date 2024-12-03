include("../scripts/common.jl")

# filename = "dec03/03-example-b.txt"
filename = "dec03/03-input.txt"

instruction_lines = aoc_read_lines(filename)

total = 0
factor = 1
for instruction in instruction_lines
    for m in eachmatch(r"(mul\(([0-9]{1,3}),([0-9]{1,3})\)|don\'t\(\)|do\(\))", instruction)
        if m.match == "do()"
            factor = 1
        end
        if m.match == "don't()"
            factor = 0
        end
        if m.match[1:3] == "mul"
            total = total + factor * parse(Int, m[2]) * parse(Int, m[3])
        end
    end
end

println("Total = ", total)
