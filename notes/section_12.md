# Plugs

There are module and function plugs. Here's a module plug:

```elixir
defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discussion.Repo
  alias Discussion.User
  alias Discussion.Route.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
  end
end
```

[Cheatsheet](https://devhints.io/phoenix-conn).

# Elixir Condition blocks

It evaluates the first true statement. It's like if elses.

```elixir
cond do
  1+1 == 5 ->
    'five'
  2 + 2 == 20 ->
    'twenty'
  true ->
    'true'
end
```
