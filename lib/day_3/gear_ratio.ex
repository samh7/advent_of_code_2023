defmodule AOC.GearRatio do
  def schematic_sum(str) do
    grid = str |> parse()

    grid
    |> Enum.flat_map(fn {position, item} ->
      case item do
        {:character, _} ->
          []

        {n, _} ->
          case adjacent_characters(grid, position) do
            [] -> []
            _ -> [n]
          end
      end
    end)
    |> Enum.sum()
  end

  def gear_ratio_sum(input) do
    grid = parse(input)

    Enum.flat_map(grid, fn {position, item} ->
      case item do
        {:character, _} ->
          []

        {n, _} when is_integer(n) ->
          adjacent_characters_part_2(grid, position)
          |> Enum.map(&{&1, n})
      end
    end)
    |> Enum.group_by(fn {key, _} -> key end)
    |> Enum.flat_map(fn {_, list} ->
      case list do
        [{_, n1}, {_, n2}] ->
          [n1 * n2]

        _ ->
          []
      end
    end)
    |> Enum.sum()
  end

  def adjacent_characters(grid, {row, col} = position) do
    {_, {_, end_col}} = grid[position]

    Enum.map(col..end_col, &{row, &1})
    |> Enum.flat_map(&adjacent/1)
    |> Enum.uniq()
    |> Enum.flat_map(fn position ->
      case grid do
        %{^position => {:character, ?*}} ->
          [position]

        %{} ->
          []
      end
    end)
    |> Enum.uniq()
  end

  # maybe useful?
  def adjacent_characters_part_2(grid, {row, col} = position) do
    {_, {_, end_col}} = grid[position]

    Enum.map(col..end_col, &{row, &1})
    |> Enum.flat_map(&adjacent/1)
    |> Enum.uniq()
    |> Enum.flat_map(fn position ->
      case grid do
        %{^position => {:character, _}} ->
          [position]

        %{} ->
          []
      end
    end)
    |> Enum.uniq()
  end

  def adjacent({row, col}),
    do: [
      {row - 1, col - 1},
      {row, col - 1},
      {row + 1, col - 1},
      {row - 1, col + 1},
      {row, col + 1},
      {row + 1, col + 1},
      {row - 1, col},
      {row, col},
      {row + 1, col}
    ]

  def parse(str),
    do:
      str
      |> String.split("\n", trim: true)
      |> Enum.with_index(&parse_line/2)
      |> Enum.concat()
      |> Map.new()

  def parse_line(line, row), do: parse_line(line, row, 0)
  defp parse_line(<<>>, _, _), do: []

  defp parse_line(<<".", body::binary>>, row, col),
    do: parse_line(body, row, col + 1)

  defp parse_line(<<digit, _::binary>> = line, row, col) when digit in ?0..?9 do
    {digits, body} = Integer.parse(line)
    digits_len = byte_size(line) - byte_size(body)

    end_pos = {row, col + digits_len - 1}

    [{{row, col}, {digits, end_pos}} | parse_line(body, row, col + digits_len)]
  end

  defp parse_line(<<character, body::binary>>, row, col),
    do: [{{row, col}, {:character, character}} | parse_line(body, row, col + 1)]
end
