# Managing dependencies

Open `mix.exs` and add dependencies to the `deps` function:

```elixir
defp deps do
[
  {:ex_doc, "~> 0.12"}
]
end
```

After that, install the dependencies with:

```
mix deps.get
```

# Documentation

```elixir
defmodule Cards do
  @moduledoc """
  Module documentation
  """

  @doc """
  Function documentation

  ## Examples

      iex> Cards.my_function
      5
  """
  def my_function do
    5
  end
end
```

Generate documentation:

```
mix docs
```
