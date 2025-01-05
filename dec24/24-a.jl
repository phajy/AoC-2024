include("../scripts/common.jl")

filename = "dec24/24-input.txt"
# filename = "dec24/24-example.txt"

lines = aoc_read_lines(filename)

# first figure out the input wire values
wire_values = Dict{String,Int}()
current_line = 1
while lines[current_line] != ""
    key, value = split(lines[current_line], ": ")
    wire_values[key] = parse(Int, value)
    current_line += 1
end

struct Gate
    inputA::String
    inputB::String
    gateType::String
    output::String
end

# then read in the gates which have input A, input B, type of gate, and output wire
gates = []
for i in current_line+1:length(lines)
    parts = split(lines[i], r" | -> ")
    println(parts)
    gate = Gate(parts[1], parts[3], parts[2], parts[5])
    push!(gates, gate)
end

# iterate until all output gates are created and resolved
maximum = 1000
done = false
while !done && maximum > 0
    maximum -= 1
    done = true
    for gate in gates
        # check to see if output has already been defined (all defined wires have values)
        if !haskey(wire_values, gate.output)
            # see if we can figure out the value (we can do this if we have both inputs)
            if haskey(wire_values, gate.inputA) && haskey(wire_values, gate.inputB)
                input_A = wire_values[gate.inputA]
                input_B = wire_values[gate.inputB]
                if gate.gateType == "AND"
                    wire_values[gate.output] = input_A & input_B
                elseif gate.gateType == "OR"
                    wire_values[gate.output] = input_A | input_B
                elseif gate.gateType == "XOR"
                    wire_values[gate.output] = input_A ⊻ input_B
                end
                # println("(", gate.inputA, " = ", input_A, ") ", gate.gateType, " (", gate.inputB, " = ", input_B, ") = (", gate.output, " = ", wire_values[gate.output], ")")
            end
            done = false
        end
    end
end

if done
    println("All gates resolved!")
end

# now calculate the total by looking a the z gates
total = 0
for wire in wire_values
    if wire[1][1] == 'z' && wire[2] == 1
        total += 2^(parse(Int, wire[1][2:3]))
    end
end

println("Total = ", total)
