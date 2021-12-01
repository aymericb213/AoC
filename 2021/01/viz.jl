using Plots

data = [-parse(Int, x) for x in readlines("input.txt")]

plot(1:2000, data,
color=:maroon, background_subplot=:sienna4, fill=(0, :aquamarine),
linewidth=5, legend=false, grid=:hide,
widen=false)
