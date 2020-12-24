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

hex_neighbours((x,y)) = [(x+i, y+j) for (i,j) in [(-1,0),(1,0),(-1,1),(0,1),(0,-1),(1,-1)]]

function add_white_tiles(black)
    white = Set()
    for tile in black
        neighbours = hex_neighbours(tile)
        for n in neighbours
            if !(n in black)
                push!(white, n)
            end
        end
    end
white end

function living_tiles(black, white)
    new_black, new_white = deepcopy(black), deepcopy(white)
    for black_tile in black
        if !(0 < count(x -> x in black, hex_neighbours(black_tile)) <= 2)
            push!(new_white, black_tile)
            filter!(tile -> tile != black_tile, new_black)
        end
    end
    for white_tile in white
        if count(x -> x in black, hex_neighbours(white_tile)) == 2
            push!(new_black, white_tile)
            filter!(tile -> tile != white_tile, new_white)
        end
    end
new_black, union!(add_white_tiles(new_black), new_white) end

function hex_game_of_life((black, white), days)
    for day in 1:days
        (black, white) = living_tiles(black, white)
    end
black, white end

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

white_tiles = add_white_tiles(black_tiles)

@test hex_neighbours((0,0)) == [(-1,0),(1,0),(-1,1),(0,1),(0,-1),(1,-1)]
@test flip_tile(["nw","w","sw","e","e"]) == (0,0)
black_tiles, white_tiles = hex_game_of_life((black_tiles, white_tiles), 100)
@show length(black_tiles)
