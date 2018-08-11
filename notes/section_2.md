# Pattern Matching

It's Elixir's replacement to variable assignment.

# Error handling

```
case File.read(filename) do
  { :ok, binary } -> :erlang.binary_to_term(binary)
  { :error, _ } -> "File does not exist"
end
```

# Pipe operator

```
Cards.create_deck
|> Cards.shuffle
|> Cards.deal(hand_size) # injects the value as the first argument
```

The operator asks us to use consistent first arguments. In this case, the first argument is the deck.
