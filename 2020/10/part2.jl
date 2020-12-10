#https://adventofcode.com/2020/day/10

adapters = open("input.txt") do file
    adapters = [parse(Int, strip(line)) for line in eachline(file)]
end

function graph(list)
    g = Dict()
    for joltage in push!(list, 0)
        g[joltage] = [adapter for adapter in list if 0 < adapter-joltage <= 3]
    end
    g[maximum(list)] = [maximum(list) + 3]
    return g
end

function nb_comb_adapters_from(adapter)
    if !(adapter in collect(keys(g)))
        return 1
    end
    if adapter in collect(keys(memo))
        return memo[adapter]
    end
    memo[adapter] = sum(nb_comb_adapters_from(next) for next in g[adapter])
    return memo[adapter]
end

g = graph(adapters)
memo = Dict()
println(@time nb_comb_adapters_from(0))
