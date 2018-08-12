defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  @doc """
  Encodes an input string using MD5, returning an
  `Identicon.Image` struct with a `hex` property.

  ## Examples:

      iex> Identicon.hash_input("banana")
      %Identicon.Image{
        hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239,
          239, 124, 65]
      }
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Fetches a set of RGB values from the image's hex data.
  The values are picked from the first 3 hex numbers.
  Returns an `Identicon.Image` with `hex` and `color` properties.

  ## Examples:

      iex> image = %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]}
      iex> Identicon.pick_color(image)
      %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}}
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Builds a grid for the passed `Identicon.Image` object.
  Returns an `Identicon.Image` with `hex`, `color` and `grid` properties.

  ## Examples:

      iex> image = %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}}
      iex> Identicon.build_grid(image)
      %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{179, 1},{2, 2},{179, 3},{114, 4},{191, 5},{41, 6},{122, 7},{41, 8},{191, 9},{34, 10},{138, 11},{117, 12},{138, 13},{34, 14},{115, 15},{1, 16},{35, 17},{1, 18},{115, 19},{239, 20},{239, 21},{124, 22},{239, 23},{239, 24}]}
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Mirrors a row from the image grid.

  ## Examples:

      iex> row = [1, 2, 3]
      iex> Identicon.mirror_row(row)
      [1, 2, 3, 2, 1]
  """
  def mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end
end
