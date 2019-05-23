require "byebug"

class Card
    attr_reader :id, :number, :suit, :name

    def initialize(number, suit)
        @id = number.upcase + suit.downcase
        @number = make_num(number)
        @suit = make_suit(suit)
        @name = get_card_name(number, @suit)
    end

    def make_num(number) 
        if number.upcase == "J" 
            return :Jack
        elsif number.upcase == "Q"
            return :Queen
        elsif number.upcase == "K"
            return :King
        elsif number.upcase == "A"
            return :Ace
        else 
            return number.to_i
        end
    end

    def make_suit(suit)
        if suit.downcase == "d"
            return "diamond"
        elsif suit.downcase == "c"
            return "club"
        elsif suit.downcase == "h"
            return "heart"
        else suit.downcase == "s"
            return "spade"
        end
    end

    def get_card_name(number, suit)
        number + " of " + suit + "s"
    end

    def card_value
        if self.number == :Jack
            return 11
        elsif self.number == :Queen
            return 12
        elsif self.number == :King 
            return 13
        elsif self.number == :Ace 
            return 14
        else  
            return self.number
        end
    end

end
