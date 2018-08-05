defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates a deck" do
    deck = Cards.create_deck
    assert Enum.member?(deck, "Ace of Spades") == true
    assert Enum.member?(deck, "Two of Diamonds") == true
  end

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
