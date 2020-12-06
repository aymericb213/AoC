#https://adventofcode.com/2020/day/6
solution = 0

open("input.txt") do file
    questions = Set()
    for line in eachline(file)
        if line == ""
            global solution += length(questions)
            questions = Set()
        else
            for char in strip(line)
                push!(questions, char)
            end
        end
    end
    #input misses an empty line as a final line so let's check the last passport here
    global solution += length(questions)
end

println(solution)
