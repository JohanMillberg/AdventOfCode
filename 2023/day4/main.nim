import strutils, sequtils, math

type
    Card = object
        givenNumbers: seq[int]
        winningNumbers: seq[int]

proc readInput(filename: string): seq[string] =
    let inputFile = readFile(filename)
    let inputStrings: seq[string] =  inputFile.strip.splitLines
    return inputStrings

proc parseCard(line: string): Card =
    let card = line.split("|")
    let givenCard = card[1].splitwhitespace()
    let parsedGivenNumbers = givenCard.mapIt(parseInt(it))
    let winningCard = card[0].split(":")[1].splitwhitespace().mapIt(parseInt(it))

    result = Card(givenNumbers: parsedGivenNumbers, winningNumbers: winningCard)

proc partOne() =
    let input = readInput("input.txt")
    var solution: int

    for line in input:
        var correctNumbers = 0
        let Card = parseCard(line)
        for number in Card.givenNumbers:
            if number in Card.winningNumbers:
                inc correctNumbers

        if correctNumbers != 0:
            solution += 2^(correctNumbers - 1)

    echo solution

proc partTwo() =
    let input = readInput("input.txt")

when isMainModule:
    partOne()
    partTwo()