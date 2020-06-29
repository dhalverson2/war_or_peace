class Turn

  attr_reader :player1,
              :player2
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def top_cards_equal?
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
  end

  def third_cards_equal?
    player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
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
end
