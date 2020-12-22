#https://adventofcode.com/2020/day/22

(capn_deck, crab_deck) = split(read("input.txt", String), "\n\n")
capn_deck, crab_deck = (split(capn_deck, "\n")[2:end], split(crab_deck, "\n")[2:end-1])

function combat(deck1, deck2)
    while !isempty(deck1) && !isempty(deck2)
        card1, card2 = popfirst!(deck1), popfirst!(deck2)
        if parse(Int, card1) > parse(Int, card2)
            push!(deck1, card1)
            push!(deck1, card2)
        elseif parse(Int, card1) < parse(Int, card2)
            push!(deck2, card2)
            push!(deck2, card1)
        end
    end
    isempty(deck1) ? deck2 : deck1
end

score(winner) = sum([i*parse(Int,reverse(winner, dims=1)[i]) for i in 1:length(winner)])
@show score(combat(capn_deck, crab_deck))
