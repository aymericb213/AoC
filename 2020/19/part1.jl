#https://adventofcode.com/2020/day/19

function explicit_rule(nb, grammar)
    subrules = grammar[nb]
    if occursin(r"[ab]", subrules)
        return strip(subrules, '\"')
    end
    for rule in eachmatch(r"(\d+)", subrules)
        subrules = replace(subrules, rule[1] => explicit_rule(rule[1], grammar), count=1)
    end
    return occursin("|", subrules) ? "($subrules)" : subrules
end

create_regex(nb, grammar) = Regex("^" * replace(explicit_rule(nb, grammar), " " => "") * "\$")

(rules, messages) = split(read("input.txt", String), "\n\n")
rulebook = Dict()
for rule in eachmatch(r"(\d+): (.*)", rules)
    rulebook[rule[1]] = rule[2]
end
messages = split(messages)

target = create_regex("0", rulebook)
@show count(i -> !isnothing(match(target, i)), messages)
