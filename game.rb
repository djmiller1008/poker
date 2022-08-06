require_relative "deck"
require_relative "player"

class Game

    attr_reader :deck, :players
    attr_accessor :current_player, :pot

    def initialize
        @deck = Deck.new
        @players = [Player.new(@deck, "Dave"), Player.new(@deck, "Kira")]
        @current_player = @players[0]
        @pot = 0
    end

    def swap_turn!
        if @current_player == @players[0]
            @current_player = @players[1]
        else  
            @current_player = @players[0]
        end
    end

    def hand_winner
        pot_render
        players[0].hand.render
        players[1].hand.render
        if players[0].hand.hand_value == players[1].hand.hand_value
            if players[0].hand.secondary_value == players[1].hand.secondary_value
                puts "Draw..."
                players[0].money += (pot / 2)
                players[1].money += (pot / 2)
            elsif players[0].hand.secondary_value.max > players[1].hand.secondary_value.max
                puts "#{players[0]} wins the hand!"
                players[0].money += pot
            else
                puts "#{players[1]} wins the hand!"
                players[1].money += pot
            end
        elsif players[0].hand.hand_value > players[1].hand.hand_value
            puts "#{players[0]} wins the hand!"
            players[0].money += pot
        else 
            puts "#{players[1]} wins the hand!"
            players[1].money += pot
        end
        sleep(3)
        system('clear')
        pot_reset
    end

    def play
        until winner?
            pot_render
            betting
            current_player.take_turn
            swap_turn!
            pot_render
            current_player.take_turn
            betting
            hand_winner
            new_hands
        end
        winner_message
    end

    def new_hands
        @players[0].new_hand
        @players[1].new_hand
    end

    def pot_reset
        @pot = 0
    end

    def betting
        bet = current_player.bet 
        swap_turn!
        if bet != 0
            @pot += bet
            if !current_player.call(bet)
                puts "#{@current_player} folds!"
                swap_turn!
                @current_player.money += pot
                new_hands
                pot_reset
                betting
            else
                @pot += bet
            end
        else 
            bet = current_player.bet
            swap_turn!
            if bet != 0
                @pot += bet
                if !current_player.call(bet)
                    puts "#{@current_player} folds!"
                    swap_turn!
                    @current_player.money += pot
                    new_hands
                    pot_reset
                    betting
                else
                    @pot += bet
                end
            end
        end
        system('clear')
    end

    def pot_render
        puts "Pot Value: #{@pot} #{@players[0]}'s money: #{@players[0].money} #{@players[1]}'s money: #{@players[1].money}"
    end
                
    def winner?
        if @players[0].money == 0 || @players[1].money == 0
            return true
        end
        false
    end

    def winner_message
        if @players[0].money == 0
            puts "#{@players[1]} is the winner!"
        else
            puts "#{@players[0]} is the winner!"
        end
    end

end



g = Game.new
g.play