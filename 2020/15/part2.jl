#https://adventofcode.com/2020/day/15

function next_number(number::Int, dict::Dict{Int,Int}, turn::Int)
    if haskey(dict, number)
        diff = (turn-1) - dict[number]
        dict[number] = turn-1
        return diff
    else
        dict[number] = turn-1
        return 0
    end
end

start = open("input.txt") do file
    start = split(readline(file), ",")
end

#Van Eck's sequence : OEIS A181391
function van_eck_at(input, turns::Int)
    memory = Dict{Int,Int}()
    for i in 1:length(input)
        memory[parse(Int, start[i])] = i
    end
    next = parse(Int, input[end])
    for turn in length(input)+1:turns
        next = next_number(next, memory, turn)
    end
    next
end

@show van_eck_at(start, 30000000)
