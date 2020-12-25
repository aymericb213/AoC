#https://adventofcode.com/2020/day/25
using Test

(card_public_key, door_public_key) = split(read("input.txt", String), "\n")
(card_public_key, door_public_key) = (parse(Int, card_public_key), parse(Int, door_public_key))

function find_loop_size(key, subject_number)
    loop_size = 0
    start = 1
    while start != key
        start = (start * subject_number) % 20201227
        loop_size += 1
    end
loop_size end

function encryption_key(subject_number, loop_size)
    start = 1
    for i in 1:loop_size
        start = (start * subject_number) % 20201227
    end
start end

@test find_loop_size(5764801, 7) == 8
@test find_loop_size(17807724, 7) == 11
@test encryption_key(17807724, 8) == 14897079
@test encryption_key(5764801, 11) == 14897079

@show encryption_key(card_public_key, find_loop_size(door_public_key, 7))
@show encryption_key(door_public_key, find_loop_size(card_public_key, 7))
