# Pattern Matching

It's Elixir's replacement to variable assignment.

# Error handling

```
{ status, binary } = File.read(filename)

case status do
  :ok -> :erlang.binary_to_term(binary)
  :error -> "File does not exist"
end
```
