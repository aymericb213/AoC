#https://adventofcode.com/2020/day/17

neighbours_3D((x,y,z)) = [(i,j,k) for i in [x-1, x, x+1] for j in [y-1, y, y+1] for k in [z-1, z, z+1] if (i,j,k) != (x,y,z)]

function next_state(dimension::Dict{Tuple, String})
    new_dimension = deepcopy(dimension)
    for cube in collect(keys(dimension))
        active = 0
        for neighbour in neighbours_3D(cube)
            if haskey(dimension, neighbour)
                active = dimension[neighbour] == "#" ? active + 1 : active
            else
                new_dimension[neighbour] = "."
            end
        end
        if dimension[cube] == "#" && !(active in [2,3])
            new_dimension[cube] = "."
        elseif dimension[cube] == "." && active == 3
            new_dimension[cube] = "#"
        end
    end
new_dimension end

function conway_3d(dimension, n)
    for cycle in 1:n
        dimension = next_state(dimension)
    end
    return dimension
end

pocket_dimension = Dict{Tuple, String}()

open("input.txt") do file
    for (y, line) in enumerate(eachline(file))
        row = split(line, "")
        for x in 1:length(row)
            pocket_dimension[(x-1, y-1, 0)] = row[x]
        end
    end
    for cube in collect(keys(pocket_dimension))
        for neighbour in neighbours_3D(cube)
            if !(haskey(pocket_dimension, neighbour))
                pocket_dimension[neighbour] = "."
            end
        end
    end
end

@show pocket_dimension
@show count(isequal("#"), collect(values(conway_3d(pocket_dimension, 6))))
