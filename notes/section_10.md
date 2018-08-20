# Resource creation flow

* Take `params` and create a `changeset` with it
* Insert it into the DB
* If successful, show resource list / show success notice
* If failure, show form / show error notice

```elixir
def create(conn, %{"topic" => topic}) do
  changeset = Topic.changeset(%Topic{}, topic)

  case Repo.insert(changeset) do
    {:ok, post} ->
      conn
      |> put_flash(:info, "Topic Created 👍")
      |> redirect(to: topic_path(conn, :index))
    {:error, changeset} ->
      render conn, "new.html", changeset: changeset
  end
end
```

# Ecto

Controller <-> Changeset <-> Repo <-> Postgres

Ecto handles Changesets + Repo. The Repo interacts with the database.

https://hexdocs.pm/ecto

```elixir
def create(conn, %{"topic" => topic}) do
  changeset = Topic.changeset(%Topic{}, topic)

  case Repo.insert(changeset) do
    {:ok, post} -> IO.inspect(post)
    {:error, changeset} -> IO.inspect(changeset)
  end
end
```

# Using the Repo to fetch data

[Repo functions](https://hexdocs.pm/ecto/Ecto.Repo.html#content).

`Repo.all` - Fetches all entries from the data store matching the given query.

There are a few ways to do things here, so this may get a bit confusing.

```elixir
iex> Discuss.Repo.all(Discuss.Topic)
SELECT t0."id", t0."title" FROM "topics" AS t0 []
[
  %Discuss.Topic{
    __meta__: #Ecto.Schema.Metadata<:loaded, "topics">,
    id: 1,
    title: "Testing"
  }
]
```

`Repo.get` - Finds a single record by id.

```elixir
iex> Discuss.Repo.get(Discuss.Topic, topic_id)
SELECT t0."id", t0."title" FROM "topics" AS t0 WHERE (t0."id" = $1) [1]
%Discuss.Topic{
  __meta__: #Ecto.Schema.Metadata<:loaded, "topics">,
  id: 1,
  title: "Testing"
}
```

# Redirecting in Phoenix

```elixir
conn
|> put_flash(:info, "Topic Created 👍")
|> redirect(to: topic_path(conn, :index))
```

# Phoenix Path Helpers

| Action | Helper |
| ---- | ---- |
| Index | `topic_path(conn, :index)` |
| New | `topic_path(conn, :new)` |
| Create | `topic_path(conn, :create)` |
| Show | `topic_path(conn, :show, ID)` |
| Edit | `topic_path(conn, :edit, ID)` |
| Update | `topic_path(conn, :create, ID)` |
| Delete | `topic_path(conn, :delete, ID)` |
