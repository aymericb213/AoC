#https://adventofcode.com/2020/day/14

function apply_mask(bitstring, mask)
    res = ""
    for i in 1:length(mask)
        if mask[i] != 'X'
            res *= mask[i]
        else
            res *= bitstring[i]
        end
    end
    res
end

mem = Dict()
open("input.txt") do file
    mask = ""
    while !eof(file)
        line = split(readline(file), " = ")
        if line[1] == "mask"
            mask = line[2]
        else
            address = line[1][5:end-1]
            mem[address] = parse(Int, apply_mask(bitstring(parse(Int, line[2]))[29:end], mask), base=2)
        end
    end
end

@show mem
println(sum(mem[key] for key in collect(keys(mem))))
