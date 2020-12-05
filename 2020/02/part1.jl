#https://adventofcode.com/2020/day/2

bounds = []
policies = []
passwords = []

open("input.txt") do file
    for line in eachline(file)
        strarray = split(line, " ")
        bs = split(strarray[1], "-")
        push!(bounds, (parse(Int,bs[1]), parse(Int,bs[2])))
        push!(policies, strarray[2][1])
        push!(passwords, strip(strarray[3]))
    end
end

solution = 0

for i in 1:length(passwords)
    occurences = count(char -> (char == policies[i]), passwords[i])
    if (bounds[i][1] <= occurences) && (occurences <= bounds[i][2])
        global solution += 1
    end
end

println(solution)
