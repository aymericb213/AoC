#https://adventofcode.com/2020/day/1

open("input.txt") do file
    expenses = [parse(Int, line) for line in eachline(file)]
    for i in 1:size(expenses, 1)
        for j in i+1:size(expenses, 1)
            for k in j+1:size(expenses, 1)
                if expenses[i]+expenses[j]+expenses[k] == 2020
                    return expenses[i]*expenses[j]*expenses[k]
                end
            end
        end
    end
end
