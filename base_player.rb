require_relative 'score'

class BasePlayer
  include Score
  attr_accessor :bank

  def initialize(bank = 100)
    @bank = bank
    @cards = []
  end

  def take(card)
    @cards.push(card) unless @cards.size == 3
  end

  def open
    @cards
  end

  def flush
    @cards = []
  end
end

