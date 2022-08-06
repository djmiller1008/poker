require "byebug"

class Card

    attr_reader :value, :suit
    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def to_s
        case @value
        when 14
            "A #{@suit}" 
        when 11
            "J #{@suit}"
        when 12
            "Q #{@suit}"
        when 13
            "K #{@suit}"
        else
            "#{@value} #{@suit}"
        end
    end


end