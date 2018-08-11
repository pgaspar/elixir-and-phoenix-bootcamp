# Pattern Matching

It's Elixir's replacement to variable assignment.

# Error handling

```
case File.read(filename) do
  { :ok, binary } -> :erlang.binary_to_term(binary)
  { :error, _ } -> "File does not exist"
end
```
