#https://adventofcode.com/2020/day/18

#https://github.com/JuliaLang/julia/blob/master/src/julia-parser.scm
⨦(x,y) = x*y ; lines = readlines("input.txt")
@show sum(l -> eval(Meta.parse(replace(l, "*" => "⨦"))), lines)
