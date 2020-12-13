#https://adventofcode.com/2020/day/12
using Match, OffsetArrays

position = (0, 0)
direction = 'E'

function move(instruction)
    (command, value) = instruction[1], parse(Int,instruction[2:end])
    if command in ['L', 'R']
        directions = ['E', 'S', 'W', 'N']
        directions = OffsetArray(directions, 0:length(directions) - 1)
        offset = command == 'R' ? value÷90 : -value÷90
        index = (findfirst(isequal(direction), directions) + offset) % length(directions)
        index = index < 0 ? length(directions) + index : index
        global direction = directions[index]
    end
    if command == 'F'
        command = direction
    end
    global position = @match command begin
                'N' => (position[1], position[2]+value)
                'E' => (position[1]+value, position[2])
                'S' => (position[1], position[2]-value)
                'W' => (position[1]-value, position[2])
                _ => position
                end
end

open("input.txt") do file
    for line in eachline(file)
        move(strip(line))
    end
end

println(position)
println(abs(position[1]) + abs(position[2]))
