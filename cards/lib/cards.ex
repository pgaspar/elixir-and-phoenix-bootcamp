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
    cards = for suit <- @deck_suits do
      for value <- @deck_values do
        "#{value} of #{suit}"
      end
    end

    List.flatten(cards)
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
end
