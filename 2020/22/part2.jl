#https://adventofcode.com/2020/day/22

(capn_deck, crab_deck) = split(read("input.txt", String), "\n\n")
capn_deck, crab_deck = (split(capn_deck, "\n")[2:end], split(crab_deck, "\n")[2:end-1])

function recursive_combat(deck1, deck2)
    previous = Set()
    while !isempty(deck1) && !isempty(deck2)
        if (deck1, deck2) in previous
            return deck1
        end
        push!(previous, (deepcopy(deck1), deepcopy(deck2)))
        card1, card2 = popfirst!(deck1), popfirst!(deck2)
        val1, val2 = parse(Int, card1), parse(Int, card2)

        if length(deck1) >= val1 && length(deck2) >= val2
            subdeck1, subdeck2 = deepcopy(deck1)[1:val1], deepcopy(deck2)[1:val2]
            rec_winner = recursive_combat(subdeck1, subdeck2) == subdeck1 ? deck1 : deck2
        end
            if ((@isdefined rec_winner) && rec_winner == deck1) || (!(@isdefined rec_winner) && val1 > val2)
                push!(deck1, card1)
                push!(deck1, card2)
            elseif ((@isdefined rec_winner) && rec_winner == deck2) || (!(@isdefined rec_winner) && val1 < val2)
                push!(deck2, card2)
                push!(deck2, card1)
            end
    end
    isempty(deck1) ? deck2 : deck1
end

score(winner) = sum([i*parse(Int,reverse(winner, dims=1)[i]) for i in 1:length(winner)])
@show score(recursive_combat(capn_deck, crab_deck))
