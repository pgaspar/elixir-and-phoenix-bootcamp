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
