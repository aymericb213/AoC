#https://adventofcode.com/2020/day/18

⨦(x,y) = x*y ; ⨰(x,y) = x+y ; lines = readlines("input.txt")
@show sum(l -> eval(Meta.parse(replace(replace(l, "*" => "⨦"), "+" => "⨰"))), lines)
