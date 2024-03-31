defmodule Cards do

  @moduledoc """
    This module contains all of the functions to create and handle deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do

    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    ### WRONG WAY:
    # cards = for suit <- suits do
    #   for value <- values do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    for suit <- suits, value <- values do
        "#{value} of #{suit}"
      end

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicated how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # This function is commented out here but left in
  #  to compare to the condensed version below it

  # def load(filename) do
  #   {status, binary} = File.read(filename)
  #   case status do
  #     :ok -> :erlang.binary_to_term binary
  #     :error -> "That file does not exist"
  #   end
  # end

  # the complicated part of below is that
  # in ONLY ONE ACTION we're comparing the returned status
  # to the defined case AND assigning the second
  # value of the tuple to the declared variable
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
    # hand
  end

end
