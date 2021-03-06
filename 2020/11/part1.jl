#https://adventofcode.com/2020/day/11

seat_map = open("input.txt") do file
    seat_map = [split(strip(line), "") for line in eachline(file)]
end

function neighbours(map, x, y)
    xi = 1 < x < length(map) ? (0, -1, 1) : x > 1 ? (0, -1) : (0, 1)
    yi = 1 < y < length(map[1]) ? (0, -1, 1) : y > 1 ? (0, -1) : (0, 1)
    [map[x + a][y + b] for a in xi for b in yi if (a != 0 || b != 0)]
end

function next_state(map)
    new_map = deepcopy(map)
    for x in 1:length(map)
        for y in 1:length(map[1])
            occupied = count(seat -> seat == "#", neighbours(map, x, y))
            if map[x][y] == "L" && occupied == 0
                new_map[x][y] = "#"
            elseif map[x][y] == "#" && occupied > 3
                new_map[x][y] = "L"
            end
        end
    end
    new_map
end

while seat_map != next_state(seat_map)
    global seat_map = next_state(seat_map)
end

println(sum(count(x -> x == "#", row) for row in seat_map))
