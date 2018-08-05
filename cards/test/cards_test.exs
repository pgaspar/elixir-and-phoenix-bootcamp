defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "greets the world" do
    assert Cards.hello() == :world
  end

  test "shuffles a deck" do
    :rand.seed(:exsplus, {1, 2, 3})
    deck = ["Ace", "Two", "Three"]
    assert Cards.shuffle(deck) == ["Two", "Ace", "Three"]
  end
end
