# Resource creation flow

* Take `params` and create a `changeset` with it
* Insert it into the DB
* If successful, show resource list / show success notice
* If failure, show form / show error notice

```elixir

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
