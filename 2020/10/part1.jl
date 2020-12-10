#https://adventofcode.com/2020/day/10

adapters = open("input.txt") do file
    adapters = [parse(Int, strip(line)) for line in eachline(file)]
end

outlet_joltage = 0
adapter_chain = [0]

while adapters != []
    best_adapter = minimum([adapter for adapter in adapters if adapter-outlet_joltage <= 3])
    push!(adapter_chain, best_adapter)
    deleteat!(adapters, findfirst(isequal(best_adapter), adapters))
    global outlet_joltage += best_adapter
end

adapter_diffs = [adapter_chain[i+1] - adapter_chain[i] for i in 1:length(adapter_chain)-1]

solution = count(x->x==1, adapter_diffs)*(count(x->x==3, adapter_diffs)+1)
println(solution)
