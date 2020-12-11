#https://adventofcode.com/2020/day/11

seat_map = open("input.txt") do file
    seat_map = [split(strip(line), "") for line in eachline(file)]
end

function neighbours_in_sight(map, x, y)
    seats = []
    directions = [(-1,0) (1,0) (0,-1) (0,1)
                  (-1,-1) (-1,1) (1,-1) (1,1)]

    for (dx, dy) in directions
        (xi, yi) = (x + dx, y + dy)
        while 1 <= xi <= length(map) && 1 <= yi <= length(map[1])
            if map[xi][yi] != "."
                push!(seats, map[xi][yi])
                break
            end
            xi += dx
            yi += dy
        end
    end
    return seats
end

function next_state(map)
    new_map = deepcopy(map)
    for x in 1:length(map)
        for y in 1:length(map[1])
            occupied = count(seat -> seat == "#", neighbours_in_sight(map, x, y))
            if map[x][y] == "L" && occupied == 0
                new_map[x][y] = "#"
            elseif map[x][y] == "#" && occupied > 4
                new_map[x][y] = "L"
            end
        end
    end
    return new_map
end

while seat_map != next_state(seat_map)
    println(sum(count(x -> x == "#", row) for row in seat_map))
    global seat_map = next_state(seat_map)
end

println(sum(count(x -> x == "#", row) for row in seat_map))
