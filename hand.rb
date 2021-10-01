require_relative 'score'

class Hand
  include Score

  def initialize
    @cards = []
  end

  def take(card)
    @cards.push(card) unless @cards.size == 3
  end

  def open
    @cards.map(&:render).join(' ')
  end

  def flush!
    @cards = []
  end
end
