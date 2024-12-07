import gleam/io
import gleam/bool
import gleam/list
import gleam/string
import gleam/int
import gleam/result
import utils/parsing

pub fn solve() {
    case parsing.read_into_lines("inputs/day2.txt") {
        Ok(content) -> {
            let part1 = solve_part1(content)
            let part2 = solve_part2(content)
            io.println("Part one: " <> part1)
            io.println("Part two: " <> part2)
        }
        Error(err) -> io.println(err)
    }
}

fn parse_to_ints(line: String) {
    line
    |> string.split(on: " ")
    |> list.map(fn(num) {
        num
        |> int.parse
        |> result.unwrap(0)
    })
}

fn solve_part1(content: List(String)) -> String {
    content
    |> list.map(fn(line) {
        line
        |> parse_to_ints
        |> is_safe
        |> bool.to_int
    })
    |> list.fold(0, fn(acc, num) {acc + num})
    |> int.to_string
}

fn solve_part2(content: List(String)) -> String {
    content
    |> list.map(fn(line) {
        line
        |> parse_to_ints
        |> generate_variations
        |> list.any(is_safe)
        |> bool.to_int
    })
    |> list.fold(0, fn(acc, num) {acc + num})
    |> int.to_string
}

fn is_safe(numbers: List(Int)) -> Bool {
    let windowed_list = numbers
    |> list.window_by_2

    let is_descending = list.all(windowed_list, fn(t) {
        let #(first, second) = t
        let result = first - second
        result >= 1 && result <= 3
    })
    let is_ascending = list.all(windowed_list, fn(t) {
        let #(first, second) = t
        let result = first - second
        result <= -1 && result >= -3
    })

    is_descending || is_ascending
}

fn generate_variations(numbers: List(Int)) {
    numbers
    |> list.index_map(fn(_, index) {
        let #(left, right) = list.split(numbers, index)
        list.append(left, list.drop(right, 1))
    })
}
