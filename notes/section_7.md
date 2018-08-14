# Phoenix version

We're using Phoenix 1.2.5. The author says this version is much easier to use than later versions.

[Changes in Phoenix 1.3.](https://medium.com/wemake-services/why-changes-in-phoenix-1-3-are-so-important-2d50c9bdabb9)

[Phoenix 1.2.5 documentation.](https://hexdocs.pm/phoenix/1.2.5/Phoenix.html)

# Phoenix commands

```
# Create app
$ mix phoenix.new app_name

# Run server
$ mix phoenix.server

# Run console
$ iex -S mix phoenix.server

# Configure database in config/dev.exs and run:
$ mix ecto.create
```

# View vs. Templates in Phoenix

When Phoenix boots up, it looks at our `views/` folder and gets the list of all views. It gets the name of each view, minus the "View" part.

It then looks at the `templates/` folder and tries to find the corresponding folder.

Phoenix then picks up the names of every file in that templates folder and makes them available to render on the View, using `render("the_file.html")`.

# Migrations

```
$ mix ecto.gen.migration add_topics
```

```elixir
defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
    end
  end
end
```

Run Migration:

```
$ mix ecto.migrate
```
