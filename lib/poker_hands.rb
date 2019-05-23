class Hand
    attr_reader :cards, :suited, :card_1, :card_2 
    attr_accessor :card_pair, :pocket_pair, :card_trips, :straight, :flush, :fullhouse, :paired_table, :tripd_table

    def initialize
        @cards = []
        @card_1 = nil
        @card_2 = nil

        @pocket_pair = false
        @suited = false
        @card_pair = [false, false]
        @card_trips = [false, false]
        @straight = false
        @flush = false
        @fullhouse = false # #fullhouse? in game.rb

        @paired_table = false
        @tripd_table = false
    end

    def suited?
        @suited = @card_1.suit == @card_2.suit
    end
    
    def pocket_pair?
        @pocket_pair = @card_1.number == @card_2.number
    end

    def length
        @cards.length
    end

    def <<(card)
        @cards << card 
        if @card_1 == nil
            @card_1 = card
        elsif @card_2 == nil
            @card_2 = card
        end
    end

    def [](idx)
        @cards[idx]
    end

    def []=(idx, ele)
        @cards[idx] = ele
    end

    def each(&block)
        @cards.each(&block)
    end

    def length
        self.cards.length
    end

    def card_pair?
        already_tested ||= false
        return true if already_tested
        if @pocket_pair || @card_pair.any? { |bool| bool }
            already_tested = true
            return true 
        end
        
    end

    def one_pair?
        counter = 0
        @card_pair.each { |bool| counter += 1 if bool }
        return counter == 1
    end

    def two_pair?
        return true if (card_pair? && @paired_table) && !@tripd_table
    end

    def both_card_pair?
        !@pocket_pair && @card_pair.all? { |bool| bool }
    end

    def card_trips?
        @card_trips.any? { |bool| bool }
    end

    def fullhouse?(table)
        cards_in_play = table + @cards
        counter = Hash.new(0)
        cards_in_play.each do |card|
            counter[card.number] += 1
        end
        trip = false
        pair = false 
        counter.each do |number, count| 
            trip = true if count == 3 
            pair = true if count == 2
        end
        @fullhouse = true if trip == true && pair == true
    end
    

end


 