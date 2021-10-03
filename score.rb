module Score
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def score
      @cards |= []
      aces = @cards.select { |card| card.value == 'A' }
      others = @cards.select { |card| card.value.match(/[\dTJQK]/) }
      sum = others.reduce(0) do |_, card|
        + card.value.match(/[TJQK]/) ? 10 : card.value.to_i
      end
      aces.reduce(sum) do |_, _|
        + sum + 11 > 21 ? 1 : 11
      end
    end
  end
end
