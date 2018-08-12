defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
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

  @doc """
  Removes odd squares from an `Identicon.Image`'s grid.
  Returns an `Identicon.Image` with an updated `grid` property.

  ## Examples:

      iex> image = %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{179, 1},{2, 2},{179, 3},{114, 4},{191, 5},{41, 6},{122, 7},{41, 8},{191, 9},{34, 10},{138, 11},{117, 12},{138, 13},{34, 14},{115, 15},{1, 16},{35, 17},{1, 18},{115, 19},{239, 20},{239, 21},{124, 22},{239, 23},{239, 24}]}
      iex> Identicon.filter_odd_squares(image)
      %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{2, 2},{114, 4},{122, 7},{34, 10},{138, 11},{138, 13},{34, 14},{124, 22}]}
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn {code, _} ->
      rem(code, 2) == 0 # Modulo
    end

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Generates a set of `(x, y)` coordinates for both the top left
  and bottom right points of every tuple on an `Identicon.Image`'s grid.
  Returns an `Identicon.Image` with `hex`, `color`, `grid` and `pixel_map`.

  ## Examples:

      iex> image = %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{2, 2},{114, 4},{122, 7},{34, 10},{138, 11},{138, 13},{34, 14},{124, 22}]}
      iex> Identicon.build_pixel_map(image)
      %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{2, 2},{114, 4},{122, 7},{34, 10},{138, 11},{138, 13},{34, 14},{124, 22}]}
      %Identicon.Image{hex: [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65], color: {114, 179, 2}, grid: [{114, 0},{2, 2},{114, 4},{122, 7},{34, 10},{138, 11},{138, 13},{34, 14},{124, 22}], pixel_map: [{{0, 0}, {50, 50}}, {{100, 0}, {150, 50}}, {{200, 0}, {250, 50}}, {{100, 50}, {150, 100}}, {{0, 100}, {50, 150}}, {{50, 100}, {100, 150}}, {{150, 100}, {200, 150}}, {{200, 100}, {250, 150}}, {{100, 200}, {150, 250}}]}
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn {_, index} ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Draws an image using an `Identicon.Image`'s `pixel_map` and Erlang's egd.
  """
  def draw_image(%Identicon.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end
end
