#https://adventofcode.com/2020/day/4
using Match

passports = []

function isinbounds(number, lb, ub)
    return number >= lb && number <= ub
end

function valid_field(field, value)
    @match field begin
        "byr" => return length(value) == 4 && isinbounds(parse(Int, value), 1920, 2002)
        "iyr" => return length(value) == 4 && isinbounds(parse(Int, value), 2010, 2020)
        "eyr" => return length(value) == 4 && isinbounds(parse(Int, value), 2020, 2030)
        "hgt" => @match value[length(value)-1:length(value)] begin
                "cm" => return isinbounds(parse(Int, value[1:length(value)-2]), 150, 193)
                "in" => return isinbounds(parse(Int, value[1:length(value)-2]), 59, 76)
                _ => return false
                end
        "hcl" => return occursin(r"^#[a-f0-9]{6}$", value)
        "ecl" => return value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        "pid" => return occursin(r"^[0-9]{9}$", value)
        _ => return false
    end
end

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
end
println(size(passports, 1))
#228
