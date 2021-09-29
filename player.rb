require_relative 'base_player'

class Player < BasePlayer
  attr_reader :name

  def initialize(name, bank = 100)
    super(bank)
    @name = name.capitalize
  end
end
