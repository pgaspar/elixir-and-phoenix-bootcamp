# Maps

[Maps](https://hexdocs.pm/elixir/Map.html) are like Javascript's Objects.

```elixir
colors = %{primary: "red", secondary: "blue"}
colors.primary # => "red"

%{secondary: secondary_color} = colors
secondary_color # => "blue"
```

Updating maps is not as simples as one would think. We can't update the map directly, we need to generate a new map with the new values.

```elixir
colors.primary = "green" # => this raises an error

# This is how we do it:
Map.put(colors, :primary, "green")
```

Alternative syntax only for updating, not for adding new keys:

```elixir
%{ colors | primary: "green" }
```

# Keyword Lists

Like lists and tuples merged together.

```elixir
iex> colors = [{:primary, "red"}, {:second, "green"}]
[primary: "red", secondary: "green"]

iex> colors[:primary]
"red"

iex> colors = [primary: "red", secondary: "blue"]
[primary: "red", secondary: "green"]
```

With maps you can only have one value per key (like a hash). With keyword lists you can have multiple values for the same key.

```elixir
iex> colors = %{ primary: "red", primary: "blue" }
%{primary: "blue"}

iex> colors = [primary: "red", primary: "red"]
[primary: "red", primary: "red"]
```

Keyword lists are used a lot in Ecto, a library for interacting with databases, which we'll use in Phoenix.

```elixir
iex> query = User.find_where where: user.age > 10, where: user.subscribed == true
```

We can remove the square brackets if the keyword list is the last argument of the function.
