require_relative 'player'
require_relative 'dealer'
require_relative 'deck'

class Game
  attr_reader :dealer, :player, :bank

  def initialize(bet = 10, bank = 100)
    @bet = bet
    @dealer = Dealer.new(bank)
    @player = Player.new(ask('What is your name? '), bank)
  end

  def start
    puts "Hello, #{player.name}! Welcome to BLACKJACK game!"
    loop do
      action = ask("#{player.name}, lets play? (y/n)")
      break if action == 'n' || (player.bank - @bet).negative? || (dealer.bank - @bet).negative?

      init
      show
      take_card = ask('take more? (y/n)')
      player.take(@deck.card) unless take_card != 'y'
      dealer.score < 17 ? dealer.take(@deck.card) : nil
      winner = win
      puts "#{winner.class != NilClass ? winner.class : 'No one'} wins!"
      take_bank(winner)
      open
    end
  end

  private

  def init
    @bank = 0
    @deck = Deck.new
    @deck.shuffle!

    player.bet(@bet)
    dealer.bet(@bet)
    @bank += @bet * 2

    player.flush
    dealer.flush
    2.times { player.take(@deck.card) }
    2.times { dealer.take(@deck.card) }
  end

  def ask(question)
    print "#{question}: "
    gets.chomp.downcase
  end

  def show
    puts "Bank #{bank}"
    show_one(player)
    show_one(dealer, true)
    puts '-' * 50
  end

  def show_one(instance, options = { hidden: false })
    cards = options[:hidden] ? instance.cards.map { |_| '*' }.join(' ') : instance.open
    score = options[:hidden] ? '' : " -score #{instance.score}"
    puts "#{instance.class} -bank $#{instance.bank} -cards #{cards}#{score}"
  end

  def open
    show_one(player)
    show_one(dealer)
    puts '-' * 50
  end

  def take_bank(winner)
    player.bank += bank if winner.instance_of? Player
    dealer.bank += bank if winner.instance_of? Dealer
    player.bank += bank && dealer.bank += bank if winner.nil?
  end

  def win
    return dealer if player.score > 21
    return player if dealer.score > 21
    return dealer if 21 - dealer.score < 21 - player.score
    return player if 21 - dealer.score > 21 - player.score

    nil if dealer.score == player.score
  end
end

Game.new.start
