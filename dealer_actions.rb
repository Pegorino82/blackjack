module DealerActions
  def dealer_take
    puts "dealer take #{@dealer.hand.score}" if @dealer.hand.score < 17
    @dealer.hand.take(@deck.card) if @dealer.hand.score < 17
  end

  def dealer_pass?
    puts "dealer pass #{@dealer.hand.score}" if @dealer.hand.score >= 17
    @dealer.hand.score >= 17
  end

  def dealer_action
    dealer_take unless dealer_pass?
  end
end
