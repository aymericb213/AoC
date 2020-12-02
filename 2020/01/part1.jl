#https://adventofcode.com/2020/day/1

open("input.txt") do file
    expenses = [parse(Int, line) for line in eachline(file)]
    for i in 1:size(expenses, 1)
        for j in i+1:size(expenses, 1)
            if expenses[i]+expenses[j] == 2020
                return expenses[i]*expenses[j]
            end
        end
    end
end
