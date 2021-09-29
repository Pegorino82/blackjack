require_relative 'score'

class BasePlayer
  include Score
  attr_accessor :bank, :cards

  def initialize(bank = 100)
    @bank = bank
    @cards = []
  end

  def bet(bet)
    @bank -= bet
  end

  def take(card)
    @cards.push(card) unless @cards.size == 3
  end

  def open
    cards.map(&:render).join(' ')
  end

  def flush
    @cards = []
  end
end
