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
      puts "\n"*3
      puts start_art
      puts "\n"*3
      sleep 0.5
      p "Welcome to War! (or Peace) This game will be played with 52 cards"
      sleep 0.25
      puts
      p "The players today are #{@player1.name} and #{@player2.name}."
      sleep 0.25
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
    if turn.winner.class == Player
      puts "\n"*3
      p "*** #{turn.winner.name} has won the game! ***"
      puts game_over_art
      puts "\n"*3
    else
      puts "\n"*3
      p "---- DRAW ----"
      puts game_over_art
      puts "\n"*3
    end
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

  def start_art
    File.read("welcome.txt") do |line|
      puts line
    end
  end

  def game_over_art
    File.read("game_over.txt") do |line|
      puts line
    end
  end
end
