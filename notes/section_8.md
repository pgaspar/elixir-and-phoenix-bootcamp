
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

# Phoenix Conventions

* Controllers are in singular form: `TopicController`, not `TopicsController`. Same applies to template folders, etc.

# Elixir code reuse

Inside a module you could:

* `import` - Copy the functions out of this module and past them on this other module
* `alias` - Give us a shortcut to another module (access another module's functions directly, but not by importing)
* `use` - Very complex setup between the two modules (update this when I know more)

There are other keywords, but these are the ones we'll use in Phoenix.

The `web/web.ex` file has the stuff we invoke when defining controllers, etc. This is super cool - I'd need to go through the rails codebase to do the same thing in Rails.

The authors specifically gave us access to this file to allow us to easily customize behavior.

# The Phoenix Conn Struct

Represents information about both the incoming request and outcoming response. This is the struct that is sent and modified through the whole pipeline. It's the focal point of what Phoenix is doing.

This is the summarized pipeline:

* Incoming Request (Conn struct)
* Ensure its an HTML request
* See if it has a session
* Do a security check
* Put on HTTP headers for a browser
* See what the request was trying to access
* Formulate and return a request <- this is where we come in

# Puts debugging

```elixir
IO.puts "++++"
IO.inspect conn
IO.puts "++++"
IO.inspect params
IO.puts "++++"
```
