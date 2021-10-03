module Score
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def score
      @cards |= []
      aces = @cards.select { |card| card.value == 'A' }
      others = @cards.select { |card| card.value.match(/[\dTJQK]/) }
      sum = others.reduce(0) do |s, card|
        card.value.to_i.zero? ? s + 10 : s + card.value.to_i
      end
      aces.reduce(sum) do |s, _|
        s + 11 > 21 ? s + 1 : s + 11
      end
    end
  end
end
