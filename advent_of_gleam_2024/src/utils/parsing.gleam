import simplifile
import gleam/string
import gleam/list

pub fn read_input(path: String) -> Result(List(String), String)  {
    case simplifile.read(path) {
        Ok(content) -> Ok(
            content
            |> string.trim
            |> split_lines
        )
        Error(_) -> Error("Could not read input file")
    }
}

fn split_lines(content: String) -> List(String) {
    content
    |> string.split(on: "\n")
    |> list.filter(fn(line) {line != ""})
}
