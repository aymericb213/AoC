#https://adventofcode.com/2020/day/24
using Test, Match

function read_directions(f)
    directions = []
    open(f) do file
        for line in eachline(file)
            tab = split(line, "")
            instruction = []
            i = 1
            while i < length(tab)+1
                if occursin("s", tab[i]) || occursin("n", tab[i])
                    push!(instruction, tab[i]*tab[i+1])
                    i+=1
                else
                    push!(instruction, tab[i])
                end
                i+=1
            end
            push!(directions, instruction)
        end
    end
directions end

function flip_tile(instruction)
    ref = (0,0)
    for dir in instruction
        coords = @match dir begin
                 "w" => (-1,0)
                 "e" => (1,0)
                 "nw" => (-1,1)
                 "ne" => (0,1)
                 "sw" => (0,-1)
                 "se" => (1,-1)
                 end
        ref = map(+, ref, coords)
    end
ref end

input = read_directions("input.txt")
black_tiles = Set()

for instruction in input
    tile_to_flip = flip_tile(instruction)
    if !(tile_to_flip in black_tiles)
        push!(black_tiles, tile_to_flip)
    else
        filter!(tile -> tile != tile_to_flip, black_tiles)
    end
end

@test flip_tile(["nw","w","sw","e","e"]) == (0,0)
@show length(black_tiles)
