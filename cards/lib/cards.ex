defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def hello do
    :world
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
end
