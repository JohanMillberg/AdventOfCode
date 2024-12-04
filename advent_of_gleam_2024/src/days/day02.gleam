import gleam/io
import gleam/list
import utils/parsing

pub fn solve() {
    case parsing.read_input("inputs/day2.txt") {
        Ok(content) -> {
            let part1 = solve_part1(content)
            let part2 = solve_part2(content)
            io.println("Part one: " <> part1)
            io.println("Part two: " <> part2)
        }
        Error(err) -> io.println(err)
    }
}

fn solve_part1(content: List(String)) -> String {
    content
    |> list.map(fn(line) {
        io.println(line)
    })
    "hello"
}

fn solve_part2(content: List(String)) -> String {
    "hello"
}