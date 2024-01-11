defmodule Colors do
  defstruct red: 0, blue: 0, green: 0
  @type t() :: %Colors{red: integer(), blue: integer(), green: integer()}
  def to_colors(%{red: red, blue: blue, green: green}) do
    %Colors{red: red, blue: blue, green: green}
  end

  def to_map(%Colors{red: red, blue: blue, green: green}) do
    %{red: red, blue: blue, green: green}
  end

  def multiply_colors(colors) do
    colors
    |> to_map
    |> Map.reject(fn {_, v} ->
      v == 0
    end)
    |> Map.values()
    |> Enum.reduce(fn x, acc ->
      x * acc
    end)
  end
end
