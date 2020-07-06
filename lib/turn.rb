class Turn

  attr_reader :player1,
              :player2,
              :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if top_cards_equal? && third_cards_equal?
      :mutually_assured_destruction
    elsif top_cards_equal?
      :war
    else
      :basic
    end
  end

  def winner
    if type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        @player1
      else
        @player2
      end
    elsif type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        @player1
      else
        @player2
      end
    else
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      spoils_of_war << @player1.deck.remove_card
      spoils_of_war << @player2.deck.remove_card
    elsif type == :war
      3.times do
        spoils_of_war << @player1.deck.remove_card
      end
      3.times do
        spoils_of_war << @player2.deck.remove_card
      end
    else
      3.times do
        @player1.deck.remove_card
      end
      3.times do
        @player2.deck.remove_card
      end
    end
  end

  def award_spoils(winner)
    @spoils_of_war.shuffle!.each do |card|
      winner.deck.cards << card unless winner == "No Winner"
    end
    @spoils_of_war = []
  end

  private

  def top_cards_equal?
    @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
  end

  def third_cards_equal?
    @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
  end
end
