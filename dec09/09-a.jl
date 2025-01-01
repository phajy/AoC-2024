include("../scripts/common.jl")

filename = "dec09/09-input.txt"
# filename = "dec09/09-example.txt"

disk = aoc_read_lines(filename)[1]

# create a map of the disc (might be too inefficient for part B but we'll see...)
begin
    disk_map = []
    data = true
    data_ix = 0
    for ix in 1:length(disk)
        n = parse(Int, disk[ix])
        if data
            val_to_push = data_ix
            data_ix += 1
        else
            val_to_push = -1
        end
        for i in 1:n
            push!(disk_map, val_to_push)
        end
        data = !data
    end
end

# defragment the disk
done = false
while !done
    done = true
    last_index = findlast(x -> x > -1, disk_map)
    first_index = findfirst(x -> x == -1, disk_map)
    println("swap ", first_index, " with ", last_index)
    if first_index < last_index
        disk_map[first_index], disk_map[last_index] = disk_map[last_index], disk_map[first_index]
        done = false
    end
end

# calculate checksum
checksum = 0
last_index = findlast(x -> x > -1, disk_map)
for i in 1:last_index
    checksum += disk_map[i] * (i - 1)
end

println("Checksum is ", checksum)
