#https://adventofcode.com/2020/day/20

image_bank = Dict()
graph = Dict()

for tile ∈ split(read("input.txt", String), "\n\n")
    id = match(r"(\d){4}", tile)
    (m, n) = 10, 10
    if !isnothing(id)
        image_bank[parse(Int, id.match)] = Matrix{Char}(undef, m, n);
        graph[parse(Int, id.match)] = []
        for x=1:m, y=1:n
            image_bank[parse(Int, id.match)][x,y] = tile[(m+1)x+y];
        end
    end
end
#=
 h   g   b   d     h   d   b   g
g d b h d g h b   d g b h g d h b
 b   d   h   g     b   g   h   d
=#

for id1 in collect(keys(image_bank))
    tiles1 = [image_bank[id1], rotl90(image_bank[id1]), rot180(image_bank[id1]),rotr90(image_bank[id1]),
    reverse(image_bank[id1], dims=2), reverse(rotl90(image_bank[id1]), dims=2),
    reverse(rot180(image_bank[id1]), dims=2), reverse(rotr90(image_bank[id1]), dims=2)]

    for id2 in collect(keys(image_bank))
        tiles2 = [image_bank[id2], rotl90(image_bank[id2]), rot180(image_bank[id2]),rotr90(image_bank[id2]),
        reverse(image_bank[id2], dims=2), reverse(rotl90(image_bank[id2]), dims=2),
        reverse(rot180(image_bank[id2]), dims=2), reverse(rotr90(image_bank[id2]), dims=2)]

        if id1 != id2 && true in [tile1[1, :] == tile2[end, :] for (tile1, tile2) in
[(x, y) for x in tiles1, y in tiles2]]
            push!(graph[id1], id2)
        end
    end
end

@show prod(id for id in collect(keys(graph)) if length(graph[id]) == 2)
