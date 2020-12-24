using Plots, Measures
using HTTP, Gumbo, Cascadia

urls = split(read("megathreads.txt", String), "\n")[126:end-1]

lang_regex = ["Python", "Rust", "Haskell", "C#", "C++", r"\"C\\\"", r"Java[^sc]", "Lisp", "Perl", "Ruby", r"([^\/]Golang|Go\/)", "PHP", "Kotlin", "Scala", "Elixir", "Javascript", r"\"R\\\"", "Prolog", "MATLAB", "Julia"]

languages = ["Python", "Rust", "Haskell", "C#", "C++", "C", "Java", "Lisp", "Perl", "Ruby", "Go", "PHP", "Kotlin", "Scala", "Elixir", "Javascript", "R", "Prolog", "MATLAB", "Julia"]

colors = ["#3572a5", "#dea584", "#5e5086", "#178600", "#f34b7d", "#555", "#b07219", "#3fb68b", "#0298c3", "#701516", "#00add8", "#4f5d95", "#f18e33", "#c22d40", "#6e4a7e", "#f1e05a", "#198ce7", "#74283c", "#e16737", "#a270ba"]

results = Matrix(undef, length(urls), length(languages))
for day in 1:length(urls)
    res = HTTP.get(urls[day])
    body = String(res.body)
    for lang in 1:length(languages)
        results[day, lang] = length(findall(lang_regex[lang], body))
    end
end
display(results)
results ./= sum(results, dims = 2)

theme(:juno)
function year_plot(year)
    portfoliocomposition(results, 1:length(urls), size = (1920, 1080),
                    title="Languages used in r/adventofcode in $year", titlefontsize = 30,
                    labels = permutedims(languages), margin = 6mm,
                    legend = :outerbottomright, legendtitle = "Language",
                    legendtitlefontsize = 18, legendfontsize = 18, labelfontsize = 20,
                    xticks=0:0.1:1, yticks=1:25,
                    palette = colors)
    xaxis!("Proportion in solutions megathread", xtickfontsize = 15)
    yaxis!("Day", ytickfontsize = 15)
    display(current())
    savefig("$year/aoc_languages_$year.svg")
end

year_plot(2020)

function full_plot()
    portfoliocomposition(results, 1:length(urls), size = (1920, 1080),
                    title="Languages used in r/adventofcode", titlefontsize = 30,
                    labels = permutedims(languages), margin = 6mm,
                    legend = :outerbottomright, legendtitle = "Language",
                    legendtitlefontsize = 18, legendfontsize = 18, labelfontsize = 20,
                    xticks=0:0.1:1, yticks=[1,25,50,75,100,125,150],
                    palette = colors)
    xaxis!("Proportion in solutions megathread", xtickfontsize = 15)
    yaxis!("2015         2016         2017         2018         2019         2020", ytickfontsize = 15)
    display(current())
    savefig("aoc_languages.svg")
end
