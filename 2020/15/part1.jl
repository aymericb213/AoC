#https://adventofcode.com/2020/day/15

memory = Dict()

function next_number(number, dict, turn)
    if number in collect(keys(dict))
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

for i in 1:length(start)
    memory[parse(Int, start[i])] = i
end

next = parse(Int, start[end])
for turn in length(start)+1:2020
    global next = next_number(next, memory, turn)
end
@show next
