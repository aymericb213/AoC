#https://adventofcode.com/2020/day/23
using Test

function moving_cups(cups, n_moves)
    solution = ""
    current_cup = cups[1]
    current_index = 1
    for i in 1:n_moves
        @show cups
        picked_cups = []
        pick_index = current_index == length(cups) ? 1 : current_index+1
        while length(picked_cups) != 3
            push!(picked_cups, cups[pick_index])
            pick_index = pick_index == length(cups) ? 1 : pick_index+1
        end

        dest_cup = current_cup-1 == 0 ? 9 : current_cup-1
        current_index += 4
        if current_index > length(cups)
            current_index = current_index%length(cups)
        end
        current_cup = cups[current_index]

        for cup in picked_cups
            deleteat!(cups, findfirst(isequal(cup), cups))
        end
        @show picked_cups

        while findfirst(isequal(dest_cup), cups) == nothing
            dest_cup = dest_cup-1 == 0 ? 9 : dest_cup-1
        end
        dest_index = findfirst(isequal(dest_cup), cups) + 1
        @show dest_cup

        for cup in reverse(picked_cups, dims=1)
            insert!(cups, dest_index, cup)
        end

        current_index = findfirst(isequal(current_cup), cups)
        @show current_cup
    end
    index_1 = findfirst(isequal(1), cups)
    for x in vcat(cups[index_1+1:end], cups[1:index_1-1])
        solution *= "$x"
    end
solution end

@testset begin
    @test moving_cups([3,8,9,1,2,5,4,6,7], 10) == "92658374"
    @test moving_cups([3,8,9,1,2,5,4,6,7], 100) == "67384529"
end

@show moving_cups([3,2,7,4,6,5,1,8,9], 100)
