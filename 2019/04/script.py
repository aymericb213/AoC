pass_min = 245318
pass_max = 765747

correct_passwds = []
for i in range(pass_min, pass_max+1):
    str_num = str(i)
    has_duplicate = False
    dup_group = "0"
    is_increasing = True
    for digit in range(1, len(str_num)):
        if str_num[digit] < str_num[digit-1]:
            is_increasing = False
            break
        if str_num[digit] == str_num[digit -1]:
            if has_duplicate and dup_group == str_num[digit]:
                has_duplicate = False
                dup_group = "0"
            else:
                dup_group = str_num[digit]
                has_duplicate = True
    if has_duplicate and is_increasing:
        correct_passwds.append(i)

print(112233 in correct_passwds)
print(123444 in correct_passwds)
print(111122 in correct_passwds)
print(len(correct_passwds))
