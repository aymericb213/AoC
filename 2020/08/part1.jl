#https://adventofcode.com/2020/day/8

bootcode = open("input.txt") do file
    bootcode = [strip(line) for line in eachline(file)]
end

acc = 0
i = 1
inst = bootcode[i]
indexes = Set()

while !(i in indexes)
    push!(indexes, i)
    command, value = split(inst, " ")
    if command == "acc"
        global acc += parse(Int, value)
        global i += 1
    elseif command == "jmp"
        global i += parse(Int, value)
    else
        global i += 1
    end
    global inst = bootcode[i]
end

println(acc)
