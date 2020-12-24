using Plots, Measures
using HTTP, Gumbo, Cascadia

function scrape_stats()
  years = 2015:2020
  urls = ["http://adventofcode.com/$year/stats" for year in years]

  stars = []
  for url in urls
    res = HTTP.get(url)
    body = String(res.body)
    html = parsehtml(body)
    gold = eachmatch(sel".stats-both", html.root)[3:end]
    silver = eachmatch(sel".stats-firstonly", html.root)[3:end]
    gcount = reverse([parse(Int, gold[i].children[1].text) for i in 1:2:length(gold)])
    scount = reverse([parse(Int, silver[i].children[1].text) for i in 1:2:length(silver)])
    yearly_stats = []
    for i in 1:length(gcount)
      push!(yearly_stats, gcount[i]+scount[i])
      push!(yearly_stats, gcount[i])
    end
    push!(stars, yearly_stats)
  end
stars end

function full_plot(data, colors)
  theme(:juno)
  aoc = plot(1:50, data, size = (1920, 1080),
            label = ["2015" "2016" 2017 2018 2019 2020],
            palette = colors,
            margin = 6mm,
            titlefontsize = 30, labelfontsize = 20,
            legendtitle = "Year", legendtitlefontsize = 18,
            legendfontsize = 15)
  title!("Advent Of Code : completion for each star")
  xaxis!("Star number", xtickfontsize = 15)
  yaxis!("Users", yminorticks = true, ytickfontsize = 15)
  xticks!(1:50)
  yticks!(0:10000:typemax(Int32))
  display(aoc)
  savefig("aoc_plot.svg")
aoc end

function single_plot(data, year, color, vlines, annotations)
  theme(:juno)
  aoc = plot(1:50, data, size = (1920, 1080), palette = [color], margin = 6mm, legend = :none,
             titlefontsize = 30)
  title!("Advent Of Code $year : completion for each star")
  xaxis!("Star number", xtickfontsize = 15)
  yaxis!("Users", yminorticks = true, ytickfontsize = 15)
  xticks!(1:50)
  yticks!(0:10000:typemax(Int32))
  vline!(vlines, label="", palette=repeat([:gray],3))
  annotate!(annotations)
  display(aoc)
  savefig("$year/aoc_plot.svg")
aoc end

stars = scrape_stats()
pal = [:plum, :red, :lawngreen, :skyblue, :yellow, :chocolate]
vlines = [[8, 38], [4,10,22,38], [6,14,28], [7], [6,14], [14,20,26,40]]
annotations = [[(7.75, stars[1][1], Plots.text("Lol", 16, :lightgray, :right)),
                (37.75, stars[1][1], Plots.text("Lol", 16, :lightgray, :right))],
               [(3.75, stars[2][1], Plots.text("Lol", 16, :lightgray, :right)),
                (9.75, stars[2][1], Plots.text("Lol", 16, :lightgray, :right)),
                (21.75, stars[2][1], Plots.text("Lol", 16, :lightgray, :right)),
                (37.75, stars[2][1], Plots.text("Lol", 16, :lightgray, :right))],
               [(5.75, stars[3][1], Plots.text("Lol", 16, :lightgray, :right)),
                (13.75, stars[3][1], Plots.text("Lol", 16, :lightgray, :right)),
                (27.75, stars[3][1], Plots.text("Lol", 16, :lightgray, :right))],
               [(6.75, stars[4][1], Plots.text("Lol", 16, :lightgray, :right))],
               [(5.75, stars[5][1], Plots.text("Lol", 16, :lightgray, :right)),
                (13.75, stars[5][1], Plots.text("Lol", 16, :lightgray, :right))],
               [(13.75, stars[6][1], Plots.text("Day 7\nThe shiny gold bag", 16, :lightgray, :right)),
                (19.75, stars[6][1], Plots.text("Day 10\nAdapter hazard", 16, :lightgray, :right)),
                (25.75, stars[6][1], Plots.text("Day 13\nChinese buses", 16, :lightgrey, :right)),
                (39.75, stars[6][1], Plots.text("Day 20\nMonster tiling", 16, :lightgrey, :right)),]]

for i in 1:6
  single_plot(stars[i], 2014+i, pal[i], vlines[i], annotations[i])
end
full_plot(stars, pal)

#=plot(full_plot(stars, pal),
     single_plot(stars[1], 2015, pal[1], vlines[1], annotations[1]),
     single_plot(stars[2], 2016, pal[2], vlines[2], annotations[2]),
     single_plot(stars[3], 2017, pal[3], vlines[3], annotations[3]),
     single_plot(stars[4], 2018, pal[4], vlines[4], annotations[4]),
     single_plot(stars[5], 2019, pal[5], vlines[5], annotations[5]),
     single_plot(stars[6], 2020, pal[6], vlines[6], annotations[6]),
     layout = @layout([a; b c d ; e f g]))=#
