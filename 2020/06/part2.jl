#https://adventofcode.com/2020/day/6
solution = 0

open("input.txt") do file
    questions = Dict()
    count = 0
    for line in eachline(file)
        if line == ""
            for question in keys(questions)
                if questions[question] == count
                    global solution += 1
                end
            end
            questions = Dict()
            count = 0
        else
            count +=1
            for char in strip(line)
                questions[char] = haskey(questions, char) ? questions[char] + 1 : 1
            end
        end
    end
    #input misses an empty line as a final line so let's process the last item here
    for question in keys(questions)
        if questions[question] == count
            global solution += 1
        end
    end
end

println(solution)
