import gleam/list
import gleam/io
import utils/parsing
import gleam/int
import gleam/dict.{type Dict, get, insert}
import gleam/string

pub fn solve() {
    case parsing.read_into_lines("inputs/day4.txt") {
        Ok(content) -> {
            let grid = content
            |> read_lines_into_dict
            let part1 = solve_part1(grid)
            let part2 = solve_part2(grid)
            io.println("Part one: " <> part1)
            io.println("Part two: " <> part2)
        }
        Error(err) -> io.println(err)
    }
}

fn read_lines_into_dict(input: List(String)) {
    input
    |> list.index_fold(dict.new(), fn(dict, line, x) {
        string.to_graphemes(line)
        |> list.index_fold(dict, fn(dict, value, y) {
            insert(dict, #(x, y), value)
        })
    })
}

fn search1(position: #(Int, Int), grid: Dict(#(Int, Int), String)) -> Int {
    let #(x, y) = position
    let directions = [
        #(#(x, y - 1), #(x, y - 2), #(x, y - 3)),
        #(#(x, y + 1), #(x, y + 2), #(x, y + 3)),
        #(#(x - 1, y), #(x - 2, y), #(x - 3, y)),
        #(#(x + 1, y), #(x + 2, y), #(x + 3, y)),
        #(#(x - 1, y - 1), #(x - 2, y - 2), #(x - 3, y - 3)),
        #(#(x + 1, y + 1), #(x + 2, y + 2), #(x + 3, y + 3)),
        #(#(x - 1, y + 1), #(x - 2, y + 2), #(x - 3, y + 3)),
        #(#(x + 1, y - 1), #(x + 2, y - 2), #(x + 3, y - 3)),
    ]

    directions
    |> list.fold(0, fn(count, direction) {
        let #(m, a, s) = direction
        case get(grid, m), get(grid, a), get(grid, s) {
            Ok("M"), Ok("A"), Ok("S") -> count + 1
            _, _, _ -> count
        }
    })
}

fn solve_part1(content: Dict(#(Int, Int), String)) -> String {
    content
    |> dict.fold(0, fn(acc, position, value) {
        case value {
            "X" -> acc + search1(position, content)
            _ -> acc
        }
    }) 
    |> int.to_string
}

fn search2(position: #(Int, Int), grid: Dict(#(Int, Int), String)) -> Int {
    let #(x, y) = position
    let nw = #(x - 1, y - 1)
    let ne = #(x + 1, y - 1)
    let sw = #(x - 1, y + 1)
    let se = #(x + 1, y + 1)

    case get(grid, nw), get(grid, se), get(grid, sw), get(grid, ne) {
        Ok("M"), Ok("S"), Ok("M"), Ok("S") -> 1
        Ok("S"), Ok("M"), Ok("S"), Ok("M") -> 1
        Ok("M"), Ok("S"), Ok("S"), Ok("M") -> 1
        Ok("S"), Ok("M"), Ok("M"), Ok("S") -> 1
        _, _, _, _ -> 0
    }
}

fn solve_part2(content: Dict(#(Int, Int), String)) -> String {
    content
    |> dict.fold(0, fn(acc, position, value) {
        case value {
            "A" -> acc + search2(position, content)
            _ -> acc
        }
    }) 
    |> int.to_string
}