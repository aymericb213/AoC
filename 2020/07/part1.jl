#https://adventofcode.com/2020/day/7

bags = Dict()

open("input.txt") do file
    for line in eachline(file)
        key, values = split(strip(replace(line, r" bags?" => "")), r" contain [0-9]? ?")
        arrval = []
        if !occursin("no other", values)
            for value in split(values, r", [0-9] ")
                push!(arrval, replace(value, "." => ""))
            end
        end
        bags[key] = arrval
    end
end

solution = Dict()

function findbag(color, dict)
    for bag in keys(dict)
        if color in dict[bag]
            solution[bag] = true
            findbag(bag, dict)
        end
    end
end
findbag("shiny gold", bags)
println(length(solution))
