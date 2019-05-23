require "byebug"
require_relative "game.rb"

game = Game.new
puts "What are your cards (enter 2 cards): "
game.i_have(game.valid_card_check(gets.chomp))
game.i_have(game.valid_card_check(gets.chomp))
puts "--------------------"
puts "my hand: #{game.print_card_ids(game.my_hand)} "
puts "on the table: N/A"
puts "\n" 
puts "Hand Strength: -- (as percentile) "
puts "Possible Outs: "

if game.my_hand.pocket_pair
    puts "  You have pocket #{game.my_hand[0].number.to_s}\'s!"
else
    puts "  Pair: #{game.my_hand[0].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[0], game.table, game.deck)} "
    puts "  Pair: #{game.my_hand[1].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[1], game.table, game.deck)} "
end
puts "  Trips: #{prob_of_trips(game.my_hand, game.table, game.deck)}"
puts "  Straight: #{prob_of_straight(game.my_hand, game.table, game.deck)}"
puts "  Flush: #{prob_of_flush(game.my_hand, game.table, game.deck)}"
puts "  Full-House: #{prob_of_fullhouse(game.my_hand, game.table, game.deck)}"
puts "\n"
puts "What was dealt: (Flop 3 cards) "
game.table_has(game.valid_card_check(gets.chomp))
game.table_has(game.valid_card_check(gets.chomp))
game.table_has(game.valid_card_check(gets.chomp))


puts "--------------------"
puts "my hand: #{game.print_card_ids(game.my_hand)} "
puts "on the table: #{game.print_card_ids(game.table)} "
puts "\n" 
puts "Hand Strength: -- (as percentile) "
puts "Possible Outs: "
if game.my_hand.pocket_pair
    puts "  You have pocket #{game.my_hand[0].number.to_s}\'s!"
else
    puts "  Pair: #{game.my_hand[0].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[0], game.table, game.deck)} "
    puts "  Pair: #{game.my_hand[1].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[1], game.table, game.deck)} "
end

trips = prob_of_trips(game.my_hand, game.table, game.deck)
if trips.is_a?(Array)
    trips.each_with_index do |probability_str, idx|
        puts "  Trip #{game.my_hand[idx].number.to_s}\'s : " + probability_str 
    end
else 
    puts "  Trips: #{trips}"
end
puts "  Straight: #{prob_of_straight(game.my_hand, game.table, game.deck)}"
puts "  Flush: #{prob_of_flush(game.my_hand, game.table, game.deck)}"
puts "  Full-House: #{prob_of_fullhouse(game.my_hand, game.table, game.deck)}"
puts "\n"
puts "What was dealt: (Turn 1 card) "
game.table_has(game.valid_card_check(gets.chomp))


puts "--------------------"
puts "my hand: #{game.print_card_ids(game.my_hand)} "
puts "on the table: #{game.print_card_ids(game.table)} "
puts "\n" 
puts "Hand Strength: -- (as percentile) "
puts "Possible Outs: "
if game.my_hand.pocket_pair
    puts "  You have pocket #{game.my_hand[0].number.to_s}\'s!"
else
    puts "  Pair: #{game.my_hand[0].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[0], game.table, game.deck)} "
    puts "  Pair: #{game.my_hand[1].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[1], game.table, game.deck)} "
end
trips = prob_of_trips(game.my_hand, game.table, game.deck)
if trips.is_a?(Array)
    trips.each_with_index do |probability_str, idx|
        puts "  Trip #{game.my_hand[idx].number.to_s}\'s : " + probability_str 
    end
else 
    puts "  Trips: #{trips}"
end
puts "  Straight: #{prob_of_straight(game.my_hand, game.table, game.deck)}"
puts "  Flush: #{prob_of_flush(game.my_hand, game.table, game.deck)}"
puts "  Full-House: #{prob_of_fullhouse(game.my_hand, game.table, game.deck)}"
puts "\n"
puts "What was dealt: (River 1 card) "
game.table_has(game.valid_card_check(gets.chomp))


puts "--------------------"
puts "my hand: #{game.print_card_ids(game.my_hand)} "
puts "on the table: #{game.print_card_ids(game.table)} "
puts "\n" 
puts "Hand Strength: -- (as percentile) "
puts "Possible Outs: "
if game.my_hand.pocket_pair
    puts "  You have pocket #{game.my_hand[0].number.to_s}\'s!"
else
    puts "  Pair: #{game.my_hand[0].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[0], game.table, game.deck)} "
    puts "  Pair: #{game.my_hand[1].number.to_s}\'s : #{prob_of_pair(game.my_hand, game.my_hand[1], game.table, game.deck)} "
end
trips = prob_of_trips(game.my_hand, game.table, game.deck)
if trips.is_a?(Array)
    trips.each_with_index do |probability_str, idx|
        puts "  Trip #{game.my_hand[idx].number.to_s}\'s : " + probability_str 
    end
else 
    puts "  Trips: #{trips}"
end
puts "  Straight: #{prob_of_straight(game.my_hand, game.table, game.deck)}"
puts "  Flush: #{prob_of_flush(game.my_hand, game.table, game.deck)}"
puts "  Full-House: #{prob_of_fullhouse(game.my_hand, game.table, game.deck)}"
puts "\n"
puts "You have a hand"
puts "--------------------"
puts "DONE"