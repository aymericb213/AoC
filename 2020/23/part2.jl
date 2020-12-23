#https://adventofcode.com/2020/day/23
using Test

function moving_cups(cups, n_moves)
    max_cup = maximum(collect(keys(cups)))
    current_cup = cups[max_cup]
    for i in 1:n_moves
        picked_cup_1 = cups[current_cup]
        picked_cup_2 = cups[picked_cup_1]
        picked_cup_3 = cups[picked_cup_2]
        post_pick_cup = cups[picked_cup_3]
        cups[current_cup] = post_pick_cup

        dest_cup = current_cup-1 == 0 ? max_cup : current_cup-1
        while dest_cup in [picked_cup_1, picked_cup_2, picked_cup_3]
            dest_cup = dest_cup-1 == 0 ? max_cup : dest_cup-1
        end
        post_dest_cup = cups[dest_cup]

        cups[dest_cup] = picked_cup_1
        cups[picked_cup_3] = post_dest_cup

        current_cup = post_pick_cup
    end
cups[1]*cups[cups[1]] end

more_cups(start, limit) = vcat(start, [n for n in maximum(start)+1:limit])

function cup_dict(list)
    d = Dict()
    for i in 1:length(list)-1
        d[list[i]] = list[i+1]
    end
    d[list[end]] = list[1]
d end

@test moving_cups(cup_dict(more_cups([3,8,9,1,2,5,4,6,7], 10^6)), 10^7) == 149245887792
@show moving_cups(cup_dict(more_cups([3,2,7,4,6,5,1,8,9], 10^6)), 10^7)
