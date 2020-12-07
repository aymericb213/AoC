#https://adventofcode.com/2020/day/4
using Match

function isinbounds(number, lb, ub)
    return number >= lb && number <= ub
end

function valid_field(field, value)
    return @match field begin
            "byr" => length(value) == 4 && isinbounds(value, "1920", "2002")
            "iyr" => length(value) == 4 && isinbounds(value, "2010", "2020")
            "eyr" => length(value) == 4 && isinbounds(value, "2020", "2030")
            "hgt" => @match value[end-1:end] begin
                    "cm" => isinbounds(value[1:end-2], "150", "193")
                    "in" => isinbounds(value[1:end-2], "59", "76")
                    _ => false
                    end
            "hcl" => occursin(r"^#[a-f0-9]{6}$", value)
            "ecl" => value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            "pid" => occursin(r"^[0-9]{9}$", value)
            _ => false
            end
end

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
                if valid_field(data[1], data[2])
                    passport[data[1]] = data[2]
                end
            end
        end
    end
    #input misses an empty line as a final line so let's check the last passport here
    nb_fields = length(collect(keys(passport)))
    if nb_fields == 8 || (nb_fields == 7 && !haskey(passport, "cid"))
        push!(passports, passport)
    end
end
println(length(passports))
