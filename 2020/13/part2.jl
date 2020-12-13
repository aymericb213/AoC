#https://adventofcode.com/2020/day/13

#Chinese Remainder Theorem
function crt(modulos, remainders)
    product = prod(modulos)
    sum((modulo-remainder) * invmod(product÷modulo, modulo) * (product÷modulo) for (modulo, remainder) in zip(modulos, remainders)) % product
end

timetable = []

open("input.txt") do file
    readline(file)
    global timetable = split(readline(file), ",")
end

busses = []
offsets = []

for i in 1:length(timetable)
    if timetable[i] != "x"
        push!(busses, parse(Int, timetable[i]))
        push!(offsets, i-1)
    end
end

@show busses
@show offsets
println(crt(busses, offsets))
