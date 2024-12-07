import gleam/regexp
import utils/parsing
import gleam/io
import gleam/list
import gleam/int
import gleam/option
import gleam/pair


pub fn solve() {
    case parsing.read_input("inputs/day3.txt") {
        Ok(content) -> {
            let part1 = solve_part1(content)
            let part2 = solve_part2(content)
            io.println("Part one: " <> part1)
            io.println("Part two: " <> part2)
        }
        Error(err) -> io.println(err)
    }
}

fn parse_mult(x: String, y: String) -> Int {
    let assert Ok(x) = int.parse(x)
    let assert Ok(y) = int.parse(y)
    x * y
}

fn solve_part1(content: String) -> String {
    let assert Ok(pattern) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")
    regexp.scan(pattern, content)
    |> list.fold(0, fn(acc, operation) {
        let assert regexp.Match(_, [option.Some(x), option.Some(y)]) = operation
        acc + parse_mult(x, y)
    })
    |> int.to_string
}

fn solve_part2(content: String) -> String {
    let pattern = "mul\\((\\d+),(\\d+)\\)|do\\(\\)|don't\\(\\)"
    let assert Ok(re) = regexp.from_string(pattern)

    regexp.scan(re, content)
    |> list.fold(#(0, True), fn(aggregated, operation) {
        case operation, aggregated {
            regexp.Match(_, [option.Some(x), option.Some(y)]), #(acc, True) -> {
                #(acc + parse_mult(x, y), True)
            }
            regexp.Match("do()", _), #(acc, _) -> #(acc, True)
            regexp.Match("don't()", _), #(acc, _)  -> #(acc, False)
            _, _ -> aggregated
        }
    })
    |> pair.first
    |> int.to_string
}