require_relative "hand"

class Player

    attr_reader :deck, :name, :hand
    attr_accessor :money

    def initialize(deck, name)
        @deck = deck
        @name = name
        @hand = Hand.new(@deck, @name)
        @money = 100
        @check = true
    end

    def to_s
        @name
    end

    def discard
        cards = []
        hand.render
        puts "#{name}, which cards do you want to discard? (type number of card (1 - 5) separated by a space, eg. 1 3 4)"
        print ">"
        discard_nums = gets.split(" ")
        discard_nums.each do |num|
            cards << hand.hand[num.to_i - 1] 
        end
        cards.each do |card|
            hand.hand.delete(card)
        end
        hand.render
    end

    def draw
        case hand.hand.length
        when 4
            puts "Dealing #{5 - hand.hand.length} card.."
            sleep(1)
        else
            puts "Dealing #{5 - hand.hand.length} cards.."
            sleep(1)
        end
        (5 - hand.hand.length).times {
            hand.hand << deck.cards[0]
            deck.cards.delete(deck.cards[0])
        }
        hand.render
    end

    def take_turn
        discard
        draw
        sleep(2)
        system('clear')
    end

    def bet
        hand.render
        puts "Do you want to bet? (Y/N) (Current money: #{money} )"
        print ">"

        if gets.chomp.upcase == "Y"
            begin
                puts "How much do you want to bet? (Current money: #{money} )"
                bet = gets.to_i
                if bet > @money
                    raise "You don't have enough money"
                end
            rescue
                puts "You don't have enough money"
                retry
            end
            @money -= bet
            return bet
        else
            return 0
        end
    end

    def call(bet)
        hand.render
        puts "Do you want to call #{bet}? (Y/N) Current money: #{money} "
        print ">"

        if gets.chomp.upcase == "Y"
            @money -= bet
            return true
        else
            return false
        end
    end

    def new_hand
        @hand = Hand.new(@deck, @name)
    end


end

