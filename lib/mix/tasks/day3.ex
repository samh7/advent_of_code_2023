defmodule Mix.Tasks.Day3 do
  use Mix.Task
  alias AOC.GearRatio

  def run(cli_args) do
    IO.inspect(cli_args)
  end

  def part1(str) do
    GearRatio.schematic_sum(str)
  end

  def part2(str) do
    GearRatio.gear_ratio_sum(str)
  end
end
