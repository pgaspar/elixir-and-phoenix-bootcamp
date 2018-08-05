# Setting up a project

Mix:

* Creates projects
* Compiles projects
* Runs 'Tasks'
* Manages Dependencies

It's like a mix between Rake and Bundler?

```
$ mix new <project_name>
```

# Interactive shell

Open a shell with the context of our a project:

```
$ iex -S mix
```

To reload your code within the shell: `recompile`

# Stylistic Conventions

* Use double quotes throughout your code. Good: `"foo"`. Bad: `'foo'`

# Function arity

`Cards.shuffle/0` means the `shuffle` function in the Cards module without any argument.

`Cards.shuffle/1` means the `shuffle` function in the Cards module without one argument.

[More info here.](https://www.culttt.com/2016/05/02/understanding-function-arity-elixir/)

# Documentation

https://hexdocs.pm/elixir/

