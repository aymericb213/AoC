def update_path(direction, value, pred):
    if direction == "R":
        return (pred[0] + value, pred[1])
    if direction == "L":
        return (pred[0] - value, pred[1])
    if direction == "U":
        return (pred[0], pred[1] + value)
    if direction == "D":
        return (pred[0], pred[1] - value)

def line_intersection(line1, line2):
    left = max(min(line1[0][0], line1[1][0]), min(line2[0][0], line2[1][0]))
    right = min(max(line1[0][0], line1[1][0]), max(line2[0][0], line2[1][0]))
    top = max(min(line1[0][1], line1[1][1]), min(line2[0][1], line2[1][1]))
    bottom = min(max(line1[0][1], line1[1][1]), max(line2[0][1], line2[1][1]))

    if top == bottom and left == right:
        return (left, top)
    
def num_steps(a,b, wire):
    if a == (0,0) or wire==[]:
        return b[0] + b[1]
    else:
        return abs(a[0] - b[0]) + abs(a[1] - b[1]) + num_steps(wire[-1], a, wire[:-1])

with open("input.txt", "r") as puzzle:
    wires = [line.split(",") for line in puzzle]
    wire1, wire2 = [(0,0)], [(0,0)]
    intersections = []
    steps = []
    for i in range(len(wires[0])):
        direction1 = wires[0][i][0]
        value1 = int(wires[0][i][1:])
        wire1.append(update_path(direction1,value1, wire1[i]))
    for i2 in range(len(wires[1])):
        direction2 = wires[1][i2][0]
        value2 = int(wires[1][i2][1:])
        wire2.append(update_path(direction2,value2, wire2[i2]))
    print(wire1)
    print(wire2)
    for j in range(1, len(wire1)):
        for k in range(1, len(wire2)):
            inter = line_intersection((wire1[j-1],wire1[j]), (wire2[k-1], wire2[k]))
            if inter is not None and inter !=(0,0):
                steps.append(num_steps(wire1[j-1],inter, wire1[:j]) + num_steps(wire2[k-1],inter, wire2[:k]))
                intersections.append(inter)
    manhattan = []
    for vertex in intersections:
        manhattan.append(abs(vertex[0]) + abs(vertex[1]))
    print(intersections)
    print(manhattan)
    minman = float("inf")
    index_vertex = 0
    for p in range(len(intersections)):
        if minman >= manhattan[p]:
            minman = manhattan[p]
            index_vertex = p
    print(minman)
    print(intersections[index_vertex])
    print(steps)
    print(min(steps))
