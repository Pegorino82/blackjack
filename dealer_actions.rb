module DealerActions
  DEALER_ENOUGH_POINTS = 17

  def dealer_take
    @dealer.hand.take(@deck.card) if @dealer.hand.score < DEALER_ENOUGH_POINTS
  end

  def dealer_pass?
    @dealer.hand.score >= DEALER_ENOUGH_POINTS
  end

  def dealer_action
    dealer_take unless dealer_pass?
  end
end
