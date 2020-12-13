#https://adventofcode.com/2020/day/13

start = 0
busses = []

open("input.txt") do file
    global start = parse(Int, readline(file))
    global busses = split(readline(file), ",")
end

min_times = []
mins = Dict()
for bus in busses
    if bus != "x"
        id = parse(Int, bus)
        min_time = id*(div(start, id)+1)
        push!(min_times, min_time)
        mins[id] = min_time
    end
end

best = minimum(min_times)

for id in collect(keys(mins))
    if mins[id] == best
        solution = id*(best - start)
        println(solution)
    end
end
