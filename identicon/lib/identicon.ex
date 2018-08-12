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
      [[114, 179, 2, 179, 114], [191, 41, 122, 41, 191], [34, 138, 117, 138, 34], [115, 1, 35, 1, 115], [239, 239, 124, 239, 239]]
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
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
