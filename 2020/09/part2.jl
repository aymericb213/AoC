#https://adventofcode.com/2020/day/9

nb = open("input.txt") do file
    nb = [parse(Int, strip(line)) for line in eachline(file)]
end

function brute_force(array::Array{Int64,1}, target)
    for i in 1:length(array)
        for j in 2:length(array)
            s = sort(array[i:j])
            if sum(s) == target
                return s[1] + s[end]
            end
        end
    end
    return 0
end

function sliding_variable_window(array::Array{Int64,1}, target)
    st = 1
    s = array[st]
    for i in 2:length(array)
        while s > target && st < i-1
            s -= array[st]
            st += 1
        end
        if s == target
            return minimum(array[st:i]) + maximum(array[st:i])
        end
        s += array[i]
    end
    return 0
end

println("Brute force")
println(@time brute_force(nb, 133015568))
println("Smart traversal")
println(@time sliding_variable_window(nb, 133015568))
