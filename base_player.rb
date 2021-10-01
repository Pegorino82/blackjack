require_relative 'score'
require_relative 'hand'

class BasePlayer
  attr_reader :name, :bank, :hand

  def initialize(name, bank = 100)
    @name = name
    @bank = bank
    @hand = Hand.new
  end

  def bet(bet)
    @bank -= bet
  end

  def win(bank)
    @bank += bank
  end
end
