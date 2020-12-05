#https://adventofcode.com/2020/day/5

function binary_seat(string)
    binnum = ""
    for char in string
        if char in ['F', 'L']
            binnum *= "0"
        else
            binnum *= "1"
        end
    end
    return parse(Int, binnum, base=2)
end

seats = open("input.txt") do file
    seats = [strip(line) for line in eachline(file)]
end

rows = [seat[1:7] for seat in seats]
columns = [seat[8:10] for seat in seats]



ids = sort([binary_seat(rows[i])*8 + binary_seat(columns[i]) for i in 1:length(rows)])

for id in ids[1:length(ids)-1]
    if !(id+1 in ids)
        println(id+1)
    end
end
