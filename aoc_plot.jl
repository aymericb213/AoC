using Plots, Measures
using DataFrames, HTTP, Gumbo, Cascadia

years = 2015:2020
urls = ["http://adventofcode.com/" * string(year) * "/stats" for year in years]

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

theme(:juno)
aoc = plot(1:50, stars, size = (1920, 1080),
          label = ["2015" "2016" 2017 2018 2019 2020],
          palette = [:white, :red, :green, :skyblue, :yellow, :plum],
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
