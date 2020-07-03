require './lib/turn'

class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start
    welcome_message
    play_game
  end

  def play_game
    turn_count = 1
      until @player1.has_lost? || @player2.has_lost? || turn_count == 1_000_000 do
        turn = Turn.new(@player1, @player2)
        p "Turn type: #{turn.type}"
        winner = turn.winner
        if turn.type == :basic
          turn.pile_cards
          turn.award_spoils(winner)
          p "Turn #{turn_count}: #{winner.name} won 2 cards"
        elsif turn.type == :basic
          turn.pile_cards
          turn.award_spoils(winner)
          p "Turn #{turn_count}: #{winner.name} won 6 cards"
        elsif turn.type == :mutually_assured_destruction
          turn.pile_cards
          p "*mutually assured destruction* 6 cards removed from play"
        end
        turn_count += 1
      end
      game_over
  end

  def game_over
    if @player1.deck.cards.count == 0
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.deck.cards.count == 0
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    else
      p "---- DRAW ----"
    end
  end

  def welcome_message
    user_input = ""
    until input == "GO" do
      p "Welcome to War! (or Peace) This game will be played with 52 cards"
      p "The players today are #{player1.name} and #{player2.name}."
      p "Type 'GO' to start the game!"
      p "------------------------------------------------------------------------"
      user_input = gets.chomp.upcase
    end
  end
end
