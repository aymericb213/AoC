#https://adventofcode.com/2020/day/9

nb = open("input.txt") do file
    nb = [parse(Int, strip(line)) for line in eachline(file)]
end

for i in 26:length(nb)
    test = nb[i]
    lb = 1
    ub = 25
    preamble = sort(nb[i-ub:i-lb])
    while preamble[lb] + preamble[ub] != test
        if preamble[lb] + preamble[ub] < test
            lb += 1
        else
            ub -= 1
        end
        if ub == 0
            println(test)
            break
        end
    end
end
