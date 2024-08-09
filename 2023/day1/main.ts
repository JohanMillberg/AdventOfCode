import { readFileSync } from "fs";
import { Solution } from "../interfaces"

class DayOne implements Solution {
    input: string[];

    constructor(inputFileName: string) {
        const text = readFileSync(inputFileName, "utf8")
        this.input = text.trim().split("\n");
    }

    partOne(): void {
        let total: number = 0;
        this.input.forEach((line: string) => {
            let digitOne: string = "", digitTwo: string = "";

            for (let c of line) {
                if (!isNaN(parseInt(c)) && digitOne.length == 0) {
                    digitOne = c;
                }

                if (!isNaN(parseInt(c))) {
                    digitTwo = c;
                }
            }

            total += Number(digitOne.concat(digitTwo));
        })

        console.log(total)
    }

    partTwo(): void {
        const numbers: { [key: string]: string } = {
            "one": '1',
            "two": '2',
            "three": '3',
            "four": '4',
            "five": '5',
            "six": '6',
            "seven": '7',
            "eight": '8',
            "nine": '9',
            1: '1',
            2: '2',
            3: '3',
            4: '4',
            5: '5',
            6: '6',
            7: '7',
            8: '8',
            9: '9',
        };

        let total: number = 0;
        let digitOne: string, digitTwo: string;
        let firstIndex: number, lastIndex: number;

        this.input.forEach((line: string) => {
            firstIndex = line.length;
            lastIndex = -1;

            for (const num in numbers) {
                if (line.indexOf(num) !== -1 && line.indexOf(num) < firstIndex) {
                    digitOne = numbers[num];
                    firstIndex = line.indexOf(num);
                }
                if (line.lastIndexOf(num) !== -1 && line.lastIndexOf(num) > lastIndex) {
                    digitTwo = numbers[num];
                    lastIndex = line.lastIndexOf(num);
                }
            }
            total += Number(digitOne.concat(digitTwo));
        })

        console.log(total)
    }
}

function main(): void {
    let dayOne = new DayOne("input.txt");
    dayOne.partOne();
    dayOne.partTwo();
}

main();
