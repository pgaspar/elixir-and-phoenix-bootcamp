# Identicon

Utility that, given a string, generates an image similar to Github's default avatars. The same string always generates the same image.

## Format

Identicons consist of a 5x5 square grid. Each square is 50px tall and wide, making the whole image 250px by 250px.

The images are vertically symmetrical. Example:

![banana.png](https://github.com/pgaspar/elixir-and-phoenix-bootcamp/blob/master/identicon/images/examples/banana.png?raw=true)

## Usage

```elixir
iex> Identicon.main("banana")
```

## Process

* Start with a string
* Compute its MD5 hash
* Get a list of numbers from the hash
* Pick a color
* Build the grid of squares
* Convert grid into image
* Save image

## Examples

```elixir
iex> Identicon.main("github")
```

![github.png](https://github.com/pgaspar/elixir-and-phoenix-bootcamp/blob/master/identicon/images/examples/github.png?raw=true)

```elixir
iex> Identicon.main("hello world")
```

![hello world.png](https://github.com/pgaspar/elixir-and-phoenix-bootcamp/blob/master/identicon/images/examples/hello%20world.png?raw=true)

```elixir
iex> Identicon.main("john")
```

![john.png](https://github.com/pgaspar/elixir-and-phoenix-bootcamp/blob/master/identicon/images/examples/john.png?raw=true)

## Generate documentation

```
$ mix docs
```

## Run tests

```
$ mix test
```
