defmodule AOC.TrebucheteTest do
  use ExUnit.Case
  doctest AOC.Trebuchete

  test "spelled out digits are distinguished between" do
    str = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    assert AOC.Trebuchete.trebuchet2(str) != AOC.Trebuchete.trebuchet1(str)
  end
end
