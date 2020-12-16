#https://adventofcode.com/2020/day/16
using Test

function check_errors(value, rules)
    for rule in collect(keys(rules))
        for interval in rules[rule]
            if parse(Int,interval[1]) <= parse(Int, value) <= parse(Int, interval[2])
                return 0
            end
        end
    end
parse(Int, value) == 0 ? 1 : parse(Int, value) end

function prepare_assignment(rules, tickets)
    candidates = Dict()
    fields = collect(keys(rules))
    for field in 1:length(fields)
        cand = []
        for i in 1:length(fields)
            completed = 0
            for ticket in tickets
                ticket_list = split(ticket, ",")
                for interval in rules[fields[field]]
                    if parse(Int, interval[1]) <= parse(Int, ticket_list[i]) <= parse(Int, interval[2])
                        completed += 1
                        break
                    end
                end
            end
            if completed == length(tickets)
                push!(cand, i)
            end
        end
        candidates[fields[field]] = cand
    end
candidates end

function assign_fields(candidates, rules, tickets)
    assignment = repeat([""], length(keys(rules)))
    while count(isequal(""), assignment) > 1
        for field in collect(keys(candidates))
            if length(candidates[field]) == 1 && !(field in assignment)
                assignment[candidates[field][1]] = field
                for key in collect(keys(candidates))
                    if key != field && candidates[field][1] in candidates[key]
                        splice!(candidates[key], findfirst(isequal(candidates[field][1]), candidates[key]))
                    end
                end
                break
            end
        end
    end
assignment end

open("input.txt") do file
    my_ticket = []
    valid_tickets = []
    rules = Dict()
    for line in eachline(file)
        if occursin("or", line)
            (name, rest) = split(line, ": ")
            (first, second) = split(rest, " or ")
            rules[name] = [split(first, "-"), split(second, "-")]
        elseif occursin("your", line)
            my_ticket = split(readline(file), ",")
        elseif occursin(",", line)
            ticket_error_rate = 0
            for value in split(line, ",")
                ticket_error_rate += check_errors(value, rules)
            end
            if ticket_error_rate == 0
                push!(valid_tickets, strip(line))
            end
        end
    end
    assignment = assign_fields(prepare_assignment(rules, valid_tickets), rules, valid_tickets)
    @show assignment
    solution = 1
    for i in 1:length(assignment)
        if occursin("departure", assignment[i])
            solution *= parse(Int, my_ticket[i])
        end
    end
    @show solution
end
