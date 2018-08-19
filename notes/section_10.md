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

```elixir
def create(conn, %{"topic" => topic}) do
  changeset = Topic.changeset(%Topic{}, topic)

  case Repo.insert(changeset) do
    {:ok, post} -> IO.inspect(post)
    {:error, changeset} -> IO.inspect(changeset)
  end
end
```
