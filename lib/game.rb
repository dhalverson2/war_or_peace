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

  def play_game
    @turn_count = 1
    until game_over? do
      turn = Turn.new(@player1, @player2)
      p "Turn type: #{turn.type}"
      winner = turn.winner
      if turn.type == :basic
        turn.pile_cards
        turn.award_spoils(winner)
        p "Turn #{turn_count}: #{winner.name} won 2 cards"
      elsif turn.type == :war
        turn.pile_cards
        turn.award_spoils(winner)
        p "Turn #{turn_count}: #{winner.name} won 6 cards"
      elsif turn.type == :mutually_assured_destruction
        turn.pile_cards
        p "*mutually assured destruction* 6 cards removed from play"
      end
    @turn_count += 1
    end
    print_game_summary
  end

  def welcome_message
    user_input = ""
    until user_input == "GO" do
      puts render_art
      puts
      sleep 1.5
      p "Welcome to War! (or Peace) This game will be played with 52 cards"
      sleep 0.75
      puts
      p "The players today are #{@player1.name} and #{@player2.name}."
      sleep 0.75
      puts
      p "Type 'GO' to start the game!"
      puts
      user_input = gets.chomp.upcase
    end
  end

  def print_game_summary
    if @player1.deck.cards.count == 0
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.deck.cards.count == 0
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    else
      p "---- DRAW ----"
    end
  end

  def print_turn_summary

  end

  def game_over?
    @player1.has_lost? || @player2.has_lost? || turn_count == 1_000_000
  end

  def render_art
    File.read("welcome.txt") do |line|
      puts line
    end
  end

end
