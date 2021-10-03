require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player_actions'
require_relative 'dealer_actions'
require_relative 'table'

class Game
  include PlayerActions
  include DealerActions
  include Table
  PLAYER_ACTIONS = [
    { command: '1', title: 'take card', action: :take },
    { command: '2', title: 'open cards', action: :open },
    { command: '3', title: 'pass', action: :pass }
  ].freeze
  GAME_ACTIONS = [
    { command: '1', title: 'play game' },
    { command: '0', title: 'exit' }
  ].freeze
  BLACK_JACK = 21
  BET = 10
  INIT_CARDS_AMOUNT = 2
  GAME_ROUNDS = PLAYER_ACTIONS.size - 1

  def initialize
    @player = Player.new(ask('What is your name? '))
    @dealer = Dealer.new('Dealer')
  end

  def start
    puts "Hello, #{@player.name}! Welcome to BLACKJACK game!"
    loop do
      show_actions(GAME_ACTIONS)
      action = gets.chomp.to_i
      break if action.zero?

      init
      game
    end
  end

  private

  def init
    @round = 1

    @deck = Deck.new
    @deck.shuffle!
    @bank = 0
    @bet = BET

    @player.bet(@bet)
    @dealer.bet(@bet)
    @bank += @bet * 2

    @player.hand.flush!
    @dealer.hand.flush!
    INIT_CARDS_AMOUNT.times { @player.hand.take(@deck.card) }
    INIT_CARDS_AMOUNT.times { @dealer.hand.take(@deck.card) }
  end

  def ask(question)
    print "#{question}: "
    gets.chomp.downcase
  end

  def show_actions(actions)
    text = "#{@player.name}, your choice:\n"
    actions.each do |action|
      text += " - #{action[:command]} to #{action[:title]}\n"
    end
    puts text + '-' * 50
  end

  def game
    loop do
      break unless @player.can_play?

      break if game_played?

      table_game
      show_actions(PLAYER_ACTIONS)
      action = player_action
      break if action.zero?

      dealer_action unless PLAYER_ACTIONS[action - 1][:action] == :open
      @round += 1
    end
  end

  def player_action
    action = gets.chomp.to_i

    send PLAYER_ACTIONS[action - 1][:action]
    action
  rescue NoMethodError
    wrong_choice
    retry
  end

  def winner
    return @dealer if @player.hand.score > BLACK_JACK
    return @player if @dealer.hand.score > BLACK_JACK
    return @dealer if BLACK_JACK - @dealer.hand.score < BLACK_JACK - @player.hand.score
    return @player if BLACK_JACK - @dealer.hand.score > BLACK_JACK - @player.hand.score

    nil if @dealer.hand.score == @player.hand.score
  end

  def game_played?
    return unless @round == GAME_ROUNDS || @dealer.hand.full?

    end_game
    table_open
    true
  end

  def end_game
    return draw if draw?

    winner.win(@bank)
  end

  def draw?
    winner.nil?
  end

  def draw
    @player.win(@bet)
    @dealer.win(@bet)
  end
end

Game.new.start
