import simplifile
import gleam/string
import gleam/list

pub fn read_input(path: String) -> Result(String, String)  {
    case simplifile.read(path) {
        Ok(content) -> Ok(
            content
            |> string.trim
        )
        Error(_) -> Error("Could not read input file")
    }
}

pub fn read_into_lines(path: String) -> Result(List(String), String)  {
    case read_input(path) {
        Ok(content) -> Ok(
            content
            |> split_lines
        )
        Error(_) -> Error("Error when splitting lines")
    }
}

fn split_lines(content: String) -> List(String) {
    content
    |> string.split(on: "\n")
    |> list.filter(fn(line) {line != ""})
}
