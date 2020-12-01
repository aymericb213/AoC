"""
def module_fuel(m):
    return (m//3)-2
"""

def module_fuel(m):
    fuel = (m//3)-2
    if fuel <= 0:
        return 0
    else:
        return fuel + module_fuel(fuel)

with open("input.txt", "r") as puzzle:
    total = 0
    for line in puzzle:
        total += module_fuel(int(line))
    print("Total : " + str(total))

