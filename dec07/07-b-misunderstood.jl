# I misunderstood the question but I like my answer to the wrong question to I am keeping it!

include("../scripts/common.jl")

filename = "dec07/07-example.txt"
# filename = "dec07/07-input.txt"

all_inst = aoc_read_lines(filename)

operators = ["+", "*", ""]
base = length(operators)

total = 0

for inst in all_inst
    println("Checking ", inst)
    split_inst = split(inst, r"(: | )")
    num_ops = length(split_inst) - 2
    can_work = false
    for i in range(1, base^num_ops)
        expression = split_inst[2]
        for j in range(1, num_ops)
            op = operators[1 + mod(div(i-1, base^(j-1)), base)]
            expression = expression * op * split_inst[j+2]
        end
        if eval(Meta.parse(expression)) == parse(Int, split_inst[1])
            can_work = true
            println("  can work with ", expression, " = ", split_inst[1])
            break
        end
    end
    if can_work
        total = total + parse(Int, split_inst[1])
    end
end

println("Total = ", total)
