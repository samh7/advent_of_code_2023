defmodule Mix.Tasks.Day2 do
  use Mix.Task
  alias AOC.CubeCondorum

  def run(cli_args) do
    if length(cli_args) == 2 do
      [part, str] = cli_args

      case part do
        "part1" ->
          part1(str)
          |> IO.inspect()

        "part2" ->
          part2(str)
          |> IO.inspect()

        _ ->
          IO.puts("Please provide a part(part1 or part2) and a string.")
      end
    else
      IO.puts("Please provide a part(part1 or part2) and a string.")
    end
  end

  def part1(str) do
    CubeCondorum.game_possible(str, %Colors{red: 12, green: 13, blue: 14})
  end

  def part2(str) do
    CubeCondorum.fewest_cube_number_possible_multiples(str)
  end
end


