defmodule AOC.Trebuchete do
  @moduledoc """
  This module houses the two functions to compute the two problems for the Trebuchete Problem (Day 1), Advent of Code.
  """
  @doc """
    Takes in a multi-line string, gets the first and last digits. If a line has only one digit, the digit
    is duplicated to make a two-digit number. The function the takes the sum of all the digits.

        iex> str = \"""
        ...>1abc2
        ...>pqr3stu8vwx
        ...>a1b2c3d4e5f
        ...>treb7uchet
        ...>\"""
        iex> AOC.Trebuchete.trebuchet1(str)
        142
  """
  def trebuchet1(str) do
    str
    |> String.replace(~r/[A-Za-z]/, "")
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, "", trim: true) |> get_first_and_last()))
    |> Enum.sum()
  end

  @doc """
    Takes in a multi-line string, gets the first and last digits (including spelled out ones eg: "one").
    If a line has only one digit, the digit is duplicated to make a two-digit number. The function the
    takes the sum of all the digits.

        iex> str = \"""
        ...>two1nine
        ...>eightwothree
        ...>abcone2threexyz
        ...>xtwone3four
        ...>4nineeightseven2
        ...>zoneight234
        ...>7pqrstsixteen
        ...>\"""
        iex> AOC.Trebuchete.trebuchet2(str)
        281
  """
  def trebuchet2(str), do: str |> convert() |> trebuchet1()

  defp convert(""), do: ""
  defp convert(<<"one", rest::binary>>), do: "1" <> convert("e" <> rest)
  defp convert(<<"two", rest::binary>>), do: "2" <> convert("o" <> rest)
  defp convert(<<"three", rest::binary>>), do: "3" <> convert("e" <> rest)
  defp convert(<<"four", rest::binary>>), do: "4" <> convert(rest)
  defp convert(<<"five", rest::binary>>), do: "5" <> convert("e" <> rest)
  defp convert(<<"six", rest::binary>>), do: "6" <> convert(rest)
  defp convert(<<"seven", rest::binary>>), do: "7" <> convert("n" <> rest)
  defp convert(<<"eight", rest::binary>>), do: "8" <> convert("t" <> rest)
  defp convert(<<"nine", rest::binary>>), do: "9" <> convert("e" <> rest)
  defp convert(<<"\n", rest::binary>>), do: "\n" <> convert(rest)
  defp convert(<<first, rest::binary>>), do: <<first>> <> convert(rest)

  defp get_first_and_last(list),
    do: "#{List.first(list)}#{List.last(list)}" |> String.to_integer()
end
