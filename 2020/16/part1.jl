#https://adventofcode.com/2020/day/16
using Test

function check_errors(value, rules)
    for rule in collect(keys(rules))
        for interval in rules[rule]
            if parse(Int,interval[1]) <= parse(Int, value) <= parse(Int, interval[2])
                return 0
            end
        end
    end
parse(Int, value) end

open("input.txt") do file
    rules = Dict()
    error_rate = 0
    for line in eachline(file)
        if occursin("or", line)
            (name, rest) = split(line, ": ")
            (first, second) = split(rest, " or ")
            rules[name] = [split(first, "-"), split(second, "-")]
        elseif occursin("your", line)
            readline(file)
        elseif occursin(",", line)
            @show line
            for value in split(line, ",")
                error_rate += check_errors(value, rules)
            end
        end
    end
    @show rules
    @show error_rate
end
