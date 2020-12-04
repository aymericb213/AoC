#https://adventofcode.com/2020/day/3

matrix = open("input.txt") do file
    matrix = [split(strip(line), "") for line in eachline(file)]
end

solution = 0
sled = (1,1)

while sled[2] <= size(matrix, 1)
    if matrix[sled[2]][sled[1]] == "#"
        global solution += 1
    end
    x = sled[1]+3 > size(matrix[1], 1) ? (sled[1]+3)%size(matrix[1],1) : sled[1]+3
    global sled = (x, sled[2]+1)
end

println(solution)
