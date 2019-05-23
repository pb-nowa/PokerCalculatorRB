require "byebug"
require_relative "game.rb"

game = Game.new
puts "What hand are you testing?"
card_1 = game.valid_card_check(gets.chomp)
card_2 = game.valid_card_check(gets.chomp)

puts "How many games would you like to trial?"
trials = gets.chomp.to_i
puts "--------------------"
games_info = Hash.new(0)
counter = 0
full_houses = []

trials.times do 
    counter += 1
    game.new_game
    game.i_have(card_1)
    game.i_have(card_2)
    game.deal_flop
    game.deal_turn
    game.deal_river
    puts "#{counter}:  #{game.print_card_ids(game.table)}"
    prob_of_pair(game.my_hand, game.my_hand[0], game.table, game.deck)
    prob_of_pair(game.my_hand, game.my_hand[1], game.table, game.deck)
    prob_of_trips(game.my_hand, game.table, game.deck)
    prob_of_straight(game.my_hand, game.table, game.deck)
    prob_of_flush(game.my_hand, game.table, game.deck)
    prob_of_fullhouse(game.my_hand, game.table, game.deck)
    
    games_info[:pair] += 1 if game.my_hand.card_pair?
    games_info[:two_pair] += 1 if game.my_hand.two_pair?
    games_info[:trip] += 1 if game.my_hand.card_trips?
    games_info[:straight] += 1 if game.my_hand.straight
    games_info[:flush] += 1 if game.my_hand.flush
    if game.my_hand.fullhouse 
        games_info[:fullhouse] += 1 
        full_houses << game.print_card_ids(game.table) + " " + game.print_card_ids(game.my_hand)
    end

end

puts "--------------------"
puts
puts "my hand: #{game.print_card_ids(game.my_hand)} "
puts 
puts "Pair: #{games_info[:pair].to_f / trials * 100.round(2)}%"
puts "Two Pair: #{games_info[:two_pair].to_f / trials * 100.round(2)}%"
puts "Trip: #{games_info[:trip].to_f / trials * 100.round(2)}%"
puts "Straight: #{games_info[:straight].to_f / trials * 100.round(2)}%"
puts "Flush: #{games_info[:flush].to_f / trials * 100.round(2)}%"
puts "Full House: #{games_info[:fullhouse].to_f / trials * 100.round(2)}%"
# puts "#{full_houses}"
