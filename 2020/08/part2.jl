#https://adventofcode.com/2020/day/8

bootcode = open("input.txt") do file
    bootcode = [strip(line) for line in eachline(file)]
end

function run_code(bootcode)
    acc = 0
    i = 1
    inst = bootcode[i]
    indexes = Set()

    while !(i in indexes)
        if i >= length(bootcode)
            return acc
        end
        push!(indexes, i)
        command, value = split(inst, " ")
        if command == "acc"
            acc += parse(Int, value)
            i += 1
        elseif command == "jmp"
            i += parse(Int, value)
        else
            i += 1
        end
    inst = bootcode[i]
    end
    return 0
end

for i in 1:length(bootcode)
    mod_bootcode = copy(bootcode)

    command, value = split(bootcode[i], " ")
    if command == "jmp"
        mod_bootcode[i] = "nop " * value
    elseif command == "nop"
        mod_bootcode[i] = "jmp " * value
    else
        continue
    end

    solution = run_code(mod_bootcode)
    if solution != 0
        println(solution)
        break
    end
end
