with open("input.txt", "r") as puzzle:
    program = puzzle.readline()
    seq = program.split(",")
    seq = [int(x) for x in seq]
    #seq[1] = 12
    #seq[2] = 2
    for noun in range(99):
        seq = program.split(",")
        seq = [int(x) for x in seq]
        seq[1] = noun
        for verb in range(99):
            seq = program.split(",")
            seq = [int(x) for x in seq]
            seq[1] = noun
            seq[2] = verb
            for i in range(0, len(seq), 4):
                if seq[i] == 1:
                    seq[seq[i+3]] = seq[seq[i+1]] + seq[seq[i+2]]
                if seq[i] == 2:
                    seq[seq[i+3]] = seq[seq[i+1]] * seq[seq[i+2]]
                if seq[i] == 99:
                    break
            if seq[0] == 19690720:
                print(noun)
                print(verb)
