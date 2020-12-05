#https://adventofcode.com/2020/day/3

matrix = open("input.txt") do file
    matrix = [split(strip(line), "") for line in eachline(file)]
end

slopes = [(1,1), (3,1), (5,1), (7,1), (1,2)]

function slide(slope)
    sled = (1,1)
    trees = 0
    while sled[2] <= length(matrix)
        if matrix[sled[2]][sled[1]] == "#"
            trees += 1
        end
        x = sled[1]+slope[1] > length(matrix[1]) ? (sled[1]+slope[1])%length(matrix[1]) : sled[1]+slope[1]
        sled = (x, sled[2]+slope[2])
    end
    return trees
end

solution = []
for slope in slopes
    push!(solution, slide(slope))
end
println(solution)
println(prod(solution))
