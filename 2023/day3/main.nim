import sets, strutils

const
    digits = {'0'..'9'}
    nonSymbols = digits + {'.'}

type GridCell = object
    value: int
    xCoord: int
    yCoord: int

proc readInput(filename: string): seq[string] =
    let inputFile = readFile(filename)
    let inputStrings: seq[string] =  inputFile.strip.splitLines
    return inputStrings

proc getNumberAtIndex(line: string, index: int): GridCell =
    if index < 0 or index > line.len or line[index] notin digits:
        return GridCell(value: -1,
                        xCoord: 0,
                        yCoord: 0)
    var i: int = index
    while i > 0 and line[i-1] in digits:
        dec i
    result.xCoord = i
    while i < line.len and line[i] in digits:
        result.value = result.value * 10 + (ord(line[i]) - ord('0'))
        inc i

proc getNumbersAroundIndex(grid: seq[string], xCoord: int, yCoord: int): HashSet[GridCell] =
    for jj in -1 .. 1:
        for ii in -1 .. 1:
            if (ii != 0 or jj != 0) and yCoord + jj >= 0 and yCoord + jj < grid.len:
                let cell = getNumberAtIndex(grid[yCoord + jj], xCoord + ii)
                if cell.value != -1:
                    result.incl(cell)

proc partOne() =
    const input = readInput("input.txt")
    var relevantNumbers: HashSet[GridCell]
    for j, line in input.pairs:
        for i in 0 .. line.len-1:
            if line[i] notin nonSymbols:
                relevantNumbers = relevantNumbers + getNumbersAroundIndex(input, i, j)
    var solution: int
    for cell in relevantNumbers:
        solution += cell.value
    echo solution

proc partTwo() =
    const input = readInput("input.txt")
    var solution: int
    for j, line in input.pairs:
        for i in 0 .. line.len-1:
            if line[i] == '*':
                let numbersAroundGear = getNumbersAroundIndex(input, i, j)
                if numbersAroundGear.len == 2:
                    var gearRatio: int = 1
                    for cell in numbersAroundGear:
                        gearRatio *= cell.value
                    solution += gearRatio
    echo solution

when isMainModule:
    partOne()
    partTwo()