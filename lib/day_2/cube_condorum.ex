defmodule AOC.CubeCondorum do
  @moduledoc """
  This module houses the two functions to compute the two problems for the
  Cube Condorum Problem (Day 2), Advent of Code.
  """
  @doc """
  Finds the sum of the game numbers of games which are possible given a set of colored cubes.
        iex> str = \"""
        ...> Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        ...> Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        ...> Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        ...> Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        ...> Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        ...>\"""
        iex> AOC.CubeCondorum.game_possible(str, %Colors{red: 12, green: 13, blue: 14})
        8
  """
  def game_possible(str, comp_colors),
    do: Game.to_game(str) |> Enum.map(&_game_possible(&1, comp_colors)) |> Enum.sum()

  defp _game_possible(
         %Game{
           no: no,
           colors: colors
         },
         default_colors
       ) do
    compare_colors(colors, default_colors, no)
  end

  @doc """
  Finds the fewest number of cubes that must be present for a game to be
  possible then gets their products then sums the products.
        iex> str = \"""
        ...> Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        ...> Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        ...> Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        ...> Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        ...> Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        ...>\"""
        iex> AOC.CubeCondorum.fewest_cube_number_possible_multiples(str)
        2286
  """
  def fewest_cube_number_possible_multiples(str),
    do:
      Game.to_game(str)
      |> Enum.map(&_fewest_cube_number_possible_multiples/1)
      |> Enum.map(&Colors.multiply_colors/1)
      |> Enum.sum()

  defp _fewest_cube_number_possible_multiples(%Game{
         no: _,
         colors: colors
       }) do
    get_largest_number(colors, %Colors{})
  end

  defp get_largest_number([], largest_colors), do: largest_colors

  defp get_largest_number(
         [%Colors{red: red1, blue: blue1, green: green1} | t],
         %Colors{red: red_largest, green: green_largest, blue: blue_largest}
       ) do
    red_largest = max(red1, red_largest)
    green_largest = max(green1, green_largest)
    blue_largest = max(blue1, blue_largest)

    get_largest_number(
      t,
      %Colors{red: red_largest, green: green_largest, blue: blue_largest}
    )
  end

  defp compare_colors([], _, no), do: no

  defp compare_colors(
         [%Colors{red: red1, blue: blue1, green: green1} | t],
         %Colors{red: red, green: green, blue: blue} = default_colors,
         no
       ) do
    case red1 <= red and
           blue1 <= blue and
           green1 <= green do
      true -> compare_colors(t, default_colors, no)
      _ -> 0
    end
  end
end
