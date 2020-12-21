#https://adventofcode.com/2020/day/21
using JuMP, GLPK

foods = split(read("input.txt", String), ")\n")[1:end-1]

food_dict = Dict()

for food in foods
    (ingredients, allergens) = split(food, " (contains ")
    allergens = split(allergens, ", ")
    recipe = split(ingredients)
    food_dict[recipe] = allergens
end

l_ingredients = reduce(union, collect(keys(food_dict)))
l_allergens = reduce(union, collect(values(food_dict)))

bin_recipes = [[ing in recipe ? 1 : 0 for ing in l_ingredients] for recipe in collect(keys(food_dict))]
bin_allergens = [[al in allergen ? 1 : 0 for al in l_allergens] for allergen in collect(values(food_dict))]

#Programme linéaire
opt = Model(GLPK.Optimizer)
@variable(opt, has_allergen[a=1:length(l_allergens), i=1:length(l_ingredients)], Bin)

#Chaque allergène dans un seul ingrédient
for a in 1:length(l_allergens)
    @constraint(opt, sum(has_allergen[a,i] for i in 1:length(l_ingredients)) == 1)
end

#Chaque ingrédient a au plus un allergène
for i in 1:length(l_ingredients)
    @constraint(opt, sum(has_allergen[a,i] for a in 1:length(l_allergens)) <= 1)
end

#Correspondance au problème
for (bin_r, bin_a) in zip(bin_recipes, bin_allergens)
    @constraint(opt, has_allergen * bin_r .>= bin_a)
end

optimize!(opt)
allergen_matrix = value.(has_allergen)

solution = 0
for (i, ingredients) in enumerate(l_ingredients)
    if all(x -> x == 0, allergen_matrix[:,i])
        for recipe in collect(keys(food_dict))
            if ingredients in recipe
                global solution += 1
            end
        end
    end
end
@show solution
