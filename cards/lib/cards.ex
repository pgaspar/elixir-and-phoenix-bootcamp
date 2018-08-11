defmodule Cards do
  @moduledoc """
  Provides functions for creating and handling a deck of cards.
  """

  @deck_values ["Ace", "King", "Jack", "Queen", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
  @deck_suits ["Spades", "Clubs", "Hearts", "Diamonds"]

  @doc """
  Returns a list of strings representing a deck of playing cards.

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "King of Spades", "Jack of Spades",
        "Queen of Spades", "Two of Spades", "Three of Spades",
        "Four of Spades", "Five of Spades", "Six of Spades",
        "Seven of Spades", "Eight of Spades", "Nine of Spades",
        "Ace of Clubs", "King of Clubs", "Jack of Clubs", "Queen of Clubs",
        "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs",
        "Six of Clubs", "Seven of Clubs", "Eight of Clubs",
        "Nine of Clubs", "Ace of Hearts", "King of Hearts",
        "Jack of Hearts", "Queen of Hearts", "Two of Hearts",
        "Three of Hearts", "Four of Hearts", "Five of Hearts",
        "Six of Hearts", "Seven of Hearts", "Eight of Hearts",
        "Nine of Hearts", "Ace of Diamonds", "King of Diamonds",
        "Jack of Diamonds", "Queen of Diamonds", "Two of Diamonds",
        "Three of Diamonds", "Four of Diamonds", "Five of Diamonds",
        "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds",
        "Nine of Diamonds"]
  """
  def create_deck do
    for suit <- @deck_suits, value <- @deck_values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffles the deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Checks if deck contains a card.

  ## Examples

      iex> Cards.contains?(["Ace", "Two"], "Ace")
      true

      iex> Cards.contains?(["Ace", "Two"], "Three")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> Cards.deal(["Ace", "Two", "Three"], 2)
      {["Ace", "Two"], ["Three"]}

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Given a deck and a `filename`, saves the deck to a file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Given a `filename`, loads a deck from the file.
  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _ } -> "File does not exist"
    end
  end

  @doc """
  Creates a deck, shuffles it and deals it (given a `hand_size`).
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
