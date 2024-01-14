defmodule Mix.Tasks.Day1 do
  use Mix.Task
  alias AOC.Trebuchete

  def run(cli_args) do
    IO.inspect(cli_args)
  end

    def part1(str) do
      Trebuchete.trebuchet1(str)
    end

    def part2(str) do
      Trebuchete.trebuchet2(str)
    end

end
