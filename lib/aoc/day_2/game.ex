defmodule Game do
  defstruct no: 0, colors: []

  def to_game(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(&_to_game_/1)
  end

  defp _to_game_(str) do
    [name, body] = str |> String.split(":", trim: true)

    no =
      name
      |> String.replace("Game ", "")
      |> String.split(" ", trim: true)
      |> Enum.join()
      |> String.to_integer()

    body =
      body
      |> String.split(";", trim: true)
      |> Enum.map(fn x ->
        x =
          x
          |> String.trim()
          |> String.split(",", trim: true)
          |> Enum.map(fn y ->
            [count, color] = y |> String.split(" ", trim: true)
            count = count |> String.to_integer()
            {:"#{color}", count}
          end)

        Enum.into(x, %{})
        |> add_filler()
        |> Colors.to_colors()
      end)

    %Game{no: no, colors: body}
  end

  defp add_filler(map) do
    map =
      case Map.has_key?(map, :red) do
        false -> Map.put_new(map, :red, 0)
        true -> map
      end

    map =
      case Map.has_key?(map, :blue) do
        false -> Map.put_new(map, :blue, 0)
        true -> map
      end

    case Map.has_key?(map, :green) do
      false -> Map.put_new(map, :green, 0)
      true -> map
    end
  end
end
