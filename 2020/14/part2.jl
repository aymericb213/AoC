#https://adventofcode.com/2020/day/14
using Combinatorics

permut = Dict()

function apply_mask(bitstring, mask)
    enum = Set()
    res = ""
    for i in 1:length(mask)
        if mask[i] != '0'
            res *= mask[i]
        else
            res *= bitstring[i]
        end
    end

    nb = count(x -> x=='X', res)
    if !(nb in collect(keys(permut)))
        permut[nb] = unique(combinations(repeat(['0','1'], nb), nb))
    end
    for x in permut[nb]
        combination = ""
        n = 1
        for j in 1:length(res)
            if res[j] != 'X'
                combination *= res[j]
            else
                combination *= x[n]
                n += 1
            end
        end
        push!(enum, combination)
    end
    enum
end

mem = Dict()
open("input.txt") do file
    mask = ""
    while !eof(file)
        line = split(readline(file), " = ")
        if line[1] == "mask"
            mask = line[2]
        else
            addresses = apply_mask(bitstring(parse(Int, line[1][5:end-1]))[29:end], mask)#36-sized mask
            for address in addresses
                mem[address] = parse(Int, line[2])
            end
        end
    end
end

println(sum(mem[key] for key in collect(keys(mem))))
