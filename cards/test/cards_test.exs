defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "shuffles a deck" do
    :rand.seed(:exsplus, {1, 2, 3})
    deck = ["Ace", "Two", "Three"]
    assert Cards.shuffle(deck) == ["Two", "Ace", "Three"]
  end

  test "checks if deck contains card" do
    deck = ["Ace", "Two", "Three"]
    assert Cards.contains?(deck, "Ace") == true
    assert Cards.contains?(deck, "Queen") == false
  end
end
