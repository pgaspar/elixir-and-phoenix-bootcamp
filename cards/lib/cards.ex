defmodule Cards do
  @moduledoc """
  Documentation for Cards.
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