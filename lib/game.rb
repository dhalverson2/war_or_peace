require './lib/turn'
require './lib/player'
require './lib/card'
require './lib/deck'

class Game

  attr_reader :turn_count
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start
    welcome_message
    play_game
  end

  def welcome_message
    user_input = ""
    until user_input == "GO" do
      # puts render_art
      # puts
      # sleep 1.0
      p "Welcome to War! (or Peace) This game will be played with 52 cards"
      # sleep 0.75
      puts
      p "The players today are #{@player1.name} and #{@player2.name}."
      # sleep 0.75
      puts
      p "Type 'GO' to start the game!"
      puts
      user_input = gets.chomp.upcase
    end
  end

  def play_game
    @turn_count = 1

    until game_over? do
      turn = Turn.new(@player1, @player2)
      p "Turn type: #{turn.type}"
      turn.pile_cards
      turn.award_spoils(turn.winner)
      print_turn_summary(turn)
      @turn_count += 1
    end
    print_game_summary(turn)
  end

  def print_game_summary(turn)
    if neither_player_won?
      p "---- DRAW ----"
    else
      p "*** #{turn.winner.name} has won the game! ***"
    end
    # if @player1.has_lost?
    #   p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    # elsif @player2.has_lost?
    #   p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    # else
    #   p "---- DRAW ----"
    # end
  end

  def print_turn_summary(turn)
    case turn.type
    when :basic
      p "Turn #{turn_count}: #{turn.winner.name} won 2 cards"
    when :war
      p "Turn #{turn_count}: WAR - #{turn.winner.name} won 6 cards"
    when :mutually_assured_destruction
      p "*mutually assured destruction* 6 cards removed from play"
    end
  end

  def game_over?
    @player1.has_lost? || @player2.has_lost? || turn_count == 1_000_000
  end

  def neither_player_won?
    !@player1.has_lost? && !@player2.has_lost?
  end

  def render_art
    File.read("welcome.txt") do |line|
      puts line
    end
  end
end
