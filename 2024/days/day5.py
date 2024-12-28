import os
from functools import reduce, cmp_to_key

def parse_input(file_content: list[str]):
    rules = {}
    updates = []

    for line in file_content:
        if '|' in line:
            left, right = list(map(int, line.split('|')))
            rules[(left, right)] = 1
            rules[(right, left)] = -1
        if ',' in line:
            updates.append(list(map(int, line.split(','))))

    return rules, updates

def is_ordered(rules, update):
    for i in range(len(update)):
        for j in range(i+1, len(update)):
            key = (update[i], update[j])
            if key in rules and rules[key] == -1:
                return False
    return True


def part1(input: list[str]):
    rules, updates = parse_input(input)
    correct_updates = []

    for update in updates:
        if is_ordered(rules, update):
            correct_updates.append(update)
    
    middle_elements = reduce(lambda acc, item: acc + [item[int((len(item)-1)/2)]], correct_updates, [])
    print(reduce(lambda acc, num: acc+num, middle_elements, 0))

def part2(input: list[str]):
    rules, updates = parse_input(input)

    def cmp(x, y):
        return rules.get((x, y), 0)

    sorted_updates = []
    for update in updates:
        if is_ordered(rules, update):
            continue
        sorted_updates.append(sorted(update, key=cmp_to_key(cmp)))

    middle_elements = reduce(lambda acc, item: acc + [item[int((len(item)-1)/2)]], sorted_updates, [])
    print(reduce(lambda acc, num: acc+num, middle_elements, 0))

if __name__=="__main__":
    script_dir = os.path.dirname(__file__)
    rel_path = "../inputs/day5.txt"
    abs_file_path = os.path.join(script_dir, rel_path)

    with open(abs_file_path) as f:
        content = list(map(str.strip, f.readlines()))
        part1(content)
        part2(content)