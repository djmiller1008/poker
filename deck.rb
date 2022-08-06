require_relative "card"
require "byebug"

class Deck

    attr_reader :cards
    def initialize
        @cards = []
        create_deck
    end

    def create_deck
        spades
        hearts
        diamonds
        clubs
    end

    def spades
        (2..14).each do |i|
            cards << Card.new(i, "♠")
        end
    end

    def hearts
        (2..14).each do |i|
            cards << Card.new(i, "♥")
        end
    end

    def clubs
        (2..14).each do |i|
            cards << Card.new(i, "♣")
        end
    end

    def diamonds
        (2..14).each do |i|
            cards << Card.new(i, "♦")
        end
    end

    def shuffle!
        cards.shuffle!
    end

    def deal_out_cards(card_array)
        card_array.each do |card|
            cards.delete(card)
        end
    end

end

 

