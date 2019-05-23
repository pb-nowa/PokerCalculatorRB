require_relative "card.rb"
require_relative "monkey_patches.rb"
require_relative "logic.rb"
require_relative "poker_hands.rb"
require "byebug"

class Game
    attr_reader :deck, :my_hand, :table
    STRAIGHTS = [
        [:Ace, 2, 3, 4, 5],
        [2, 3, 4, 5, 6],
        [3, 4, 5, 6, 7],
        [4, 5, 6, 7, 8],
        [5, 6, 7, 8, 9],
        [6, 7, 8, 9, 10],
        [7, 8, 9, 10, :Jack],
        [8, 9, 10, :Jack, :Queen],
        [9, 10, :Jack, :Queen, :King],
        [10, :Jack, :Queen, :King, :Ace]
        ]
    @@suits = ["d","c","h","s"] 
    @@numbers = ["2","3","4","5","6","7","8","9","10", "J", "Q", "K", "A"] 

    def initialize
        @deck = []
        @my_hand = Hand.new
        @table = []
        self.new_game
    end

    def new_game
        @@suits.each do |suits_idx|
            @@numbers.each do |numbers_idx|    
                card = Card.new(numbers_idx, suits_idx)
                @deck << card
            end
        end
        @my_hand = Hand.new
        @table = []
    end

    def valid_card_check(card_id)
        if card_id.length < 2 || card_id.include?(" ")
            puts "enter a valid card: "
            valid_card_check(gets.chomp)
        end
        
        true_id = ""
        true_id += card_id[0].upcase
        true_id += card_id[1].downcase
        true_id += card_id[2].downcase if card_id.length == 3

        if @deck.include_id?(true_id)
            return card_id.strip
        else
            puts "enter a valid card: "
            valid_card_check(gets.chomp)
        end
    end

    def remove_card(location, card_id)
        location.delete_if { |card| card.id == card_id}        
    end 

    def i_have(card_id)
        number = id_to_num(card_id)
        suit = id_to_suit(card_id)
        new_card = Card.new(number, suit)
        @my_hand << new_card
        self.remove_card(@deck, new_card.id)
        if @my_hand.length == 2
            @my_hand.pocket_pair? 
            @my_hand.suited?
        end 
    end

    def table_has(card_id)
        number = id_to_num(card_id)
        suit = id_to_suit(card_id)
        new_card = Card.new(number, suit)
        @table << new_card
        self.remove_card(@deck, new_card.id)
    end

    def id_to_num(card_id)
        if card_id[0] == "1"
            return "10"
        else 
            card_id[0]
        end
    end

    def id_to_suit(card_id)
        if card_id[0] == "1"
            return card_id[2]
        else
            card_id[1]
        end
    end

    def deal_flop
        3.times do 
            @table << @deck.sample
            @table.each { |card| remove_card( @deck, card.id ) }
        end
    end

    def deal_turn
        @table << @deck.sample
        @table.each { |card| remove_card( @deck, card.id ) }
    end

    def deal_river
        @table << @deck.sample
        @table.each { |card| remove_card( @deck, card.id ) }
    end

    def print_card_ids(cards)
        cards_ids = []
        cards.each do |card|
            cards_ids << card.id
        end
        cards_ids.join(" ")
    end

end 

