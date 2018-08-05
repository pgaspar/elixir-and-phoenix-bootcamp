defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @deck_values ["Ace", "King", "Jack", "Queen", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
  @deck_suits ["Spades", "Clubs", "Hearts", "Diamonds"]

  @doc """
  Generates a deck of cards.
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
  Given a deck, returns a tuple with a hand of hand_size and
  the remaining deck.

  ## Examples

      iex> Cards.deal(["Ace", "Two", "Three"], 2)
      {["Ace", "Two"], ["Three"]}
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
end
