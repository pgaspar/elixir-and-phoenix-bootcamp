# MD5 hashing

```elixir
iex> hash = :crypto.hash(:md5, "banana")
<<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>

iex> Base.encode16(hash)
"72B302BF297A228A75730123EFEF7C41"
```

# Building a square grid from the MD5 hash

First, we drop the last number of the list - we only need 15 numbers.

| | | | | |
| - | - | - | - | - |
| 1 | 2 | 3 | 2 | 1 |
| 4 | 5 | 6 | 5 | 4 |
| 7 | 8 | 9 | 8 | 7 |
| 10 | 11 | 12 | 11 | 10 |
| 13 | 14 | 15 | 14 | 13 |

```elixir
iex> hash = [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
```

The numbers on the table are indexes of the hash list.

Then, for each square, if the corresponding hash number is even, we mark we color it. If it's odd we leave it white.
