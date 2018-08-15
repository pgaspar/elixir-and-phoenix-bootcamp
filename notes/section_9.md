# Models

1 - Implement the model's `schema`
2 - Define `changeset` function for validations

I think on Phoenix 1.3 `schema` became its own thing, outside the model. I also think they no longer call these classes "models".

```elixir
defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end

  # Validate title is present
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
```

Beware, [changesets](https://hexdocs.pm/ecto/Ecto.Changeset.html#content) are confusing.

The `struct` argument is a hash that contains some data. It represents a record in the database (or one we want to create).

`params` is a hash that contains the properties we want to change and their new values.

`cast` produces a changeset, which represents the change we want to make.

`validate_...` adds errors to the changeset

The returned value is the changeset which knows what we want to change and if there are validation errors.

Practical example on the console:

```elixir
iex> struct = %Discuss.Topic{}
%Discuss.Topic{
  __meta__: #Ecto.Schema.Metadata<:built, "topics">,
  id: nil,
  title: nil
}

iex> params = %{title: "Great JS"}
%{title: "Great JS"}

iex> Discuss.Topic.changeset(struct, params)
#Ecto.Changeset<
  action: nil,
  changes: %{title: "Great JS"},
  errors: [],
  data: #Discuss.Topic<>,
  valid?: true
>

iex> Discuss.Topic.changeset(struct, %{})
#Ecto.Changeset<
  action: nil,
  changes: %{},
  errors: [title: {"can't be blank", [validation: :required]}],
  data: #Discuss.Topic<>,
  valid?: false
>
```

PS: `use Discuss.Web, :model` creates a struct witht the model's name for us `%Discuss.Topic{}`, which we're using above.

When we save to the database, we save the changeset, not the struct.

# Default params on Elixir

```elixir
def changeset(struct, params \\ %{})
  ...
```
