require_relative "deck"

class Hand

    attr_reader :deck, :name
    attr_accessor :value, :hand

    def initialize(deck, name)
        @deck = deck
        @name = name
        @hand = []
        create_hand
        @value = {}
    end

    def create_hand
        deck.shuffle!
        deck.cards[0..4].each do |card|
            hand << card
        end
        deck.deal_out_cards(hand)
    end

    def pairs?
        count = 0
        cards = []
        hand.each_with_index do |card, i|
            (i + 1...hand.length).each do |j|
                if hand[i].value == hand[j].value
                    count += 1
                    if !cards.include?(hand[i])
                        cards << hand[i]
                    end
                end
            end
        end
        if count == 1
            value[1] = cards[0].value
        elsif count == 2 
            value[2] = [cards[0].value, cards[1].value]
        elsif count == 3
            value[3] = cards[0].value
        elsif count == 4
            value[6] = [cards[0].value, cards[1].value]
        elsif count > 4
            value[7] = cards[0].value
        else
            high_card
        end
    end

    def high_card
        values = hand.map { |card| card.value }
        values = values.sort
        value[0] = values[-1]
        values[-1]
    end

    def flush?
        s = hand[0].suit
        hand.each do |card|
            if card.suit != s
                return false
            end
        end
        true
    end

    def straight?
        values = hand.map { |card| card.value }
        values = values.sort
        (0..3).each do |i|
            if values[i] != (values[i + 1] - 1)
                return false
            end
        end
        true
    end

    def royal?
        royal = [10, 11, 12, 13, 14]
        values = hand.map { |card| card.value }
        values.sort
        if values == royal && flush?
            value[9] = 14
            return true
        end
        false
    end

    def check_hand
        return if royal?
        if straight? && flush?
            value[8] = high_card
        end
        pairs?
        straight?
        flush?
        high_card
    end

    def hand_value
        check_hand
        value.keys.max
    end

    def secondary_value
        value[value.keys.max]
    end

    def render
        puts "#{@name}:  #{hand[0]} #{hand[1]} #{hand[2]} #{hand[3]} #{hand[4]}"
    end
       
end

