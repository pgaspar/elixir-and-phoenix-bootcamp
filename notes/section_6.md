# Structs

A map used to store data in an elixir application. They can have default values and have extra type validation on compile.

Struct definition:

```elixir
defmodule Identicon.Image do
  defstruct hex: nil # Defaults to nil
end
```

Use the struct:

```elixir
iex> %Identicon.Image{}
%Identicon.Image{hex: nil}

iex> %Identicon.Image{hex: []}
%Identicon.Image{hex: []}
```

Structs enforce that the only properties that can exist are the ones defined when defining the struct.

# Updating a Struct

```elixir
iex> image = %Identicon.Image{hex: [1, 2, 3]}
%Identicon.Image{hex: [1, 2, 3]}

iex> %Identicon.Image{image | color: {0, 150, 255}}
%Identicon.Image{hex: [1, 2, 3], color: {0, 150, 255}}
```

# Concatenating Arrays

```elixir
iex> [1, 2, 3] ++ [4, 5]
[1, 2, 3, 4, 5]
```

# Enum.map

```elixir
iex> Enum.map([1, 2, 3], fn x -> x * 2 end)
[2, 4, 6]

iex> Enum.map([1, 2, 3], &duplicate/1)
[2, 4, 6]
```

`&duplicate/1` is a pointer to the function `duplicate` with 1 argument. It's similar to how you can `[1,2,3].map(&:upcase)` in Ruby.

# Image manipulation

There's no built-in lib for this - we're going to use [Erlang's egd](http://erlang.org/documentation/doc-6.1/lib/percept-0.8.9/doc/html/egd.html).

Install it with:

```elixir
{:egd, github: "erlang/egd"}
```

Functions we're going to use:
* `egd.create()`
* `egd.filledRectangle(image, point, point, color)`
* `egd.color(color)`
* `egd.render(image)`

Top left of the image is `(0, 0)`.

Egd is interesting in that it seems to modify the images we pass in to its functions, instead of returning new objects.
