include("../scripts/common.jl")

# filename = "dec07/07-example.txt"
filename = "dec07/07-input.txt"

all_inst = aoc_read_lines(filename)

operators = ['+', '*', '|']
base = length(operators)

total = 0

for inst in all_inst
    split_inst = split(inst, r"(: | )")
    split_inst = parse.(Int, split_inst)
    num_ops = length(split_inst) - 2
    can_work = false
    for i in range(1, base^num_ops)
        answer = split_inst[2]
        for j in range(1, num_ops)
            op = operators[1 + mod(div(i-1, base^(j-1)), base)]
            if op == '+'
                answer = answer + split_inst[j+2]
            elseif op == '*'
                answer = answer * split_inst[j+2]
            elseif op == '|'
                answer = parse(Int, string(answer) * string(split_inst[j+2]))
            end
        end
        if answer == split_inst[1]
            can_work = true
            break
        end
    end
    if can_work
        total = total + split_inst[1]
    end
end

println("Total = ", total)
