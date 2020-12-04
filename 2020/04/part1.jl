#https://adventofcode.com/2020/day/4
passports = []

open("input.txt") do file
    passport = Dict()
    for line in eachline(file)
        if line == ""
            nb_fields = length(collect(keys(passport)))
            if nb_fields == 8 || (nb_fields == 7 && !haskey(passport, "cid"))
                push!(passports, passport)
            end
            passport = Dict()
        else
            for field in split(strip(line), " ")
                data = split(field, ":")
                passport[data[1]] = data[2]
            end
        end
    end
    #input misses an empty line as a final line so let's check the last passport here
    nb_fields = length(collect(keys(passport)))
    if nb_fields == 8 || (nb_fields == 7 && !haskey(passport, "cid"))
        push!(passports, passport)
    end
end
println(size(passports, 1))
