#https://adventofcode.com/2020/day/12
using Match, OffsetArrays

position = (0, 0)
waypoint = (10, 1)

function move(instruction)
    (command, value) = instruction[1], parse(Int,instruction[2:end])
    if command in ['L', 'R']
        turns = div(value, 90)
        while turns > 0
            global waypoint = command == 'R' ? (waypoint[2], -waypoint[1]) : (-waypoint[2], waypoint[1])
            turns -= 1
        end
    elseif command == 'F'
        global position = (position[1]+value*waypoint[1], position[2]+value*waypoint[2])
    else
        global waypoint = @match command begin
                'N' => (waypoint[1], waypoint[2]+value)
                'E' => (waypoint[1]+value, waypoint[2])
                'S' => (waypoint[1], waypoint[2]-value)
                'W' => (waypoint[1]-value, waypoint[2])
                _ => waypoint
                end
    end
end

open("input.txt") do file
    for line in eachline(file)
        move(strip(line))
    end
end

println(position)
println(waypoint)
println(abs(position[1]) + abs(position[2]))
