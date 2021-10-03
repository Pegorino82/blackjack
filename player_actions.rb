module PlayerActions
  private

  def take
    @player.hand.take(@deck.card)
  end

  def pass; end

  def open
    @player.hand.open
  end
end
