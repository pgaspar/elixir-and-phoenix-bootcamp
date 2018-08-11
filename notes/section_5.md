# MD5 hashing

```elixir
iex> hash = :crypto.hash(:md5, "banana")
<<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>

iex> Base.encode16(hash)
"72B302BF297A228A75730123EFEF7C41"
```
