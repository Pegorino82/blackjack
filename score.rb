module Score
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def score
      @cards |= []
      aces = @cards.select { |card| card.value == 'A' }
      others = @cards.select { |card| card.value.match(/[\dTJQK]/) }
      sum = others.reduce(0) do |sum, card|
        card.value.match(/[TJQK]/) ? sum += 10 : sum += card.value.to_i
      end
      aces.reduce(sum) do |sum, _|
        sum + 11 > 21 ? sum += 1 : sum += 11
      end
    end
  end
end
