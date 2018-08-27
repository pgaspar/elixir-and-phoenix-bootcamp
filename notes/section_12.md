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

Function plugs are defined within controllers:

```elixir
plug :check_something

defp check_something do
  # ...
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

# Restricting User Access

We want to restrict `new`, `create`, `delete`, `edit` and `update` to signed in users.

Deleting and editing needs to also check if the user owns the topic.

```elixir
plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
```

# Model Associations

For simple "has many" relationships, add the foreign key to the table that is contained:

```elixir
defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users)
    end
  end
end
```

Migrate, then add the associations to the models:

```elixir
defmodule Discuss.User do
  # ...

  schema "users" do
    # ...
    has_many :topics, Discuss.Topic
  end
end

defmodule Discuss.Topic do
  # ...

  schema "topics" do
    # ...
    belongs_to :user, Discuss.User
  end
end
```

[More details](https://hexdocs.pm/ecto/Ecto.Schema.html#content).

PS: these changes require a server restart.

# Creating associated records

The `Ecto` module itself also has some functions attached to it. Like `build_assoc`.

```elixir
changeset =
  conn.assigns.user
  |> build_assoc(:topics)
  |> Topic.changeset(topic)

Repo.insert!(changeset)
```

Read more about `build_assoc` [here](https://hexdocs.pm/ecto/Ecto.html#build_assoc/3) and [here](https://hexdocs.pm/ecto/associations.html#one-to-many).

# Updating associations

```elixir
iex> u = Discuss.Repo.get(Discuss.User, 1)
iex> t = Discuss.Repo.get(Discuss.Topic, 2) |> Discuss.Repo.preload(:user)
iex> Ecto.Changeset.change(t) |> Ecto.Changeset.put_assoc(:user, u) |> Discuss.Repo.update!
```

# Browsing an Association

```elixir
iex> Discuss.Repo.get(Discuss.User, 1)
# Results in <association :topics is not loaded>

iex> Discuss.Repo.get(Discuss.User, 1) |> Discuss.Repo.preload(:topics)
```
