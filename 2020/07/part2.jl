#https://adventofcode.com/2020/day/7

bags = Dict()

open("input.txt") do file
    for line in eachline(file)
        key, values = split(strip(replace(line, r" bags?" => "")), r" contain ")
        arrval = []
        if !occursin("no other", values)
            for value in split(values, r", ")
                push!(arrval, replace(value, "." => ""))
            end
        end
        bags[key] = arrval
    end
end

solution = 0
level = ""
memoisator = Dict()

function bagscontainedin(bag)
    println(level * bag)
    if bag in collect(keys(memoisator))
        return memoisator[bag]
    end
    sum = 0
    global level *= "-"
    for color in bags[bag]
        nb = parse(Int, color[1])
        sum += nb*(1+bagscontainedin(color[3:end]))
    end
    global level = level[1:end-1]
    memoisator[bag] = sum
    return sum
end

println(bagscontainedin("shiny gold"))
