defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates a deck" do
    deck = Cards.create_deck
    assert Enum.member?(deck, "Ace of Spades") == true
    assert Enum.member?(deck, "Two of Diamonds") == true
    assert length(deck) == 48
  end

  test "shuffling a deck randomizes it" do
    :rand.seed(:exsplus, {1, 2, 3})
    deck = ["Ace", "Two", "Three"]
    assert Cards.shuffle(deck) == ["Two", "Ace", "Three"]
  end

  test "checks if deck contains card" do
    deck = ["Ace", "Two", "Three"]
    assert Cards.contains?(deck, "Ace") == true
    assert Cards.contains?(deck, "Queen") == false
  end

  test "deals a hand" do
    deck = ["Ace", "Two", "Three", "Four"]
    { hand, deck } = Cards.deal(deck, 2)
    assert hand == ["Ace", "Two"]
    assert deck == ["Three", "Four"]
  end

  test "creates a hand" do
    :rand.seed(:exsplus, {1, 2, 3})
    { hand, deck} = Cards.create_hand(3)
    assert hand == ["Three of Clubs", "Two of Clubs", "Nine of Hearts"]
    assert deck == ["Six of Spades", "Eight of Spades", "Queen of Hearts",
      "Seven of Spades", "Ace of Hearts", "Jack of Diamonds",
      "Two of Spades", "Four of Clubs", "King of Diamonds",
      "Three of Hearts", "Seven of Clubs", "Five of Clubs",
      "Ace of Clubs", "Two of Diamonds", "Five of Diamonds",
      "Four of Diamonds", "Four of Spades", "Nine of Clubs",
      "Seven of Hearts", "Seven of Diamonds", "Five of Hearts",
      "Eight of Clubs", "Three of Spades", "Queen of Clubs",
      "Three of Diamonds", "King of Clubs", "King of Spades",
      "Six of Diamonds", "Ace of Spades", "Jack of Hearts",
      "King of Hearts", "Two of Hearts", "Jack of Clubs",
      "Five of Spades", "Nine of Spades", "Four of Hearts",
      "Nine of Diamonds", "Six of Hearts", "Ace of Diamonds",
      "Six of Clubs", "Queen of Spades", "Eight of Hearts",
      "Jack of Spades", "Queen of Diamonds", "Eight of Diamonds"]
  end
end
