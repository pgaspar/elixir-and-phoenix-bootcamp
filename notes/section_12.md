# Plugs

There are module and function plugs. Here's a module plug:

PS: we're required to define `init` and `call` even if we don't use them. Also, the `params` in `call` is whatever is returned on the `init` function.

```elixir
defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discussion.Repo
  alias Discussion.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end
```

Or:

```elixir
defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn # No-Op
    else
      conn
      |> put_flash(:error, "You must be logged in 😳")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
```

Inside of a Plug we need to explicitly `halt()` if we want this to stop execution. Otherwise it will go on to the next plug.

Plugs are setup on the `router.ex` file to run every time or on specific controllers:

```elixir
# On the router:

pipeline :browser do
  # ...
  plug :put_secure_browser_headers
  plug Discuss.Plugs.SetUser
end

# On a controller:

plug Discuss.Plugs.RequireAuth

# Or with a guard clause

plug Discuss.Plugs.RequireAuth when action in [:new]
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

# Restricting User Access

We want to restrict `new`, `create`, `delete`, `edit` and `update` to signed in users.

Deleting and editing needs to also check if the user owns the topic.

```elixir
plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
```
