# Managing dependencies

Open `mix.exs` and add dependencies to the `deps` function:

```
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
