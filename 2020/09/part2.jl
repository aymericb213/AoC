#https://adventofcode.com/2020/day/9

nb = open("input.txt") do file
    nb = [parse(Int, strip(line)) for line in eachline(file)]
end

target = 133015568
for i in 1:length(nb)
    for j in 2:length(nb)
        s = sort(nb[i:j])
        if sum(s) == target
            println(string(s[1] + s[end]))
            break
        end
    end
end
