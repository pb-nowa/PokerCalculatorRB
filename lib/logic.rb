require_relative "game.rb"
require "byebug"

def prob_of_straight(my_hand, table, deck)
    if table.length == 5 && possible_straight?(my_hand, table)
        my_hand.straight = true 
        return true
    end
end

def possible_straight?(my_hand, table)
    my_nums = get_all_nums(my_hand, table)
    straight_outs = []
    Game::STRAIGHTS.each do |straight|
        straight_outs << straight if my_nums.at_least?(table.length, straight)
    end
    if straight_outs.empty?
        return false 
    else
        straight_outs
    end
end

def get_all_nums(my_hand, table)
    all_cards = my_hand.cards + table 
    all_cards.map { |card| card.number }
end

def factorial(num)
    total = 1
    num.downto(1).each { |i| total *= i }
    return total
end

#n are number of options. r are numbers of tries
def c(n,r)
    return factorial(n) * 1.0 / ( factorial(r) * factorial(n - r) )
end

def probability_of_success(table, deck, outs)
    a = deck.length #num of cards in deck
    b = outs.length # nums of outs
    c = 5 - table.length # remaining draws

    probability_of_failure = (factorial(a-b) * factorial(a-c)).to_f / (factorial(a) * factorial(a-b-c))
    probability_of_success = 1 - probability_of_failure

    return probability_of_success
end  

def probability_of_one_combination(table, deck, outs, out_successes)
    
    a = deck.length
    b = outs.length
    c = 5 - table.length
    d = out_successes #number of outs for success 

    one_combination = (factorial(b) * factorial(a-b) * factorial(a-c)).to_f / (factorial(a) * factorial(b-d) * factorial(a-c-b+d))
    return one_combination
end

def pair?(my_hand, table)
    return my_hand.pocket_pair
    my_hand.each.with_index do |my_card, idx|
        table.each do |table_card|
            if my_card.number == table_card.number
                my_hand.card_pair[idx] = true
                return true 
            end
        end
    end
    false
end

def pair_outs(my_card, table, deck)
    outs = []
    deck.each { |deck_card| outs << deck_card if my_card.number == deck_card.number }
    return outs 
end

def prob_of_pair(my_hand, my_card, table, deck)
    if table.include_number?(my_card.number)
        i = 0
        while i < 2
            my_hand.card_pair[i] = true if my_card == my_hand[i]
            i += 1
        end
        return "100%" 
    end
    outs = pair_outs(my_card, table, deck)
    probability = probability_of_success(table, deck, outs).round(4)
    probability *= 100
    return "#{probability}% "
end

def prob_of_trips(my_hand, table, deck)
    if trips?(my_hand, table)
        return "100%"

    elsif my_hand.pocket_pair
        outs = pair_outs(my_hand[0], table, deck)
        probability = probability_of_success(table, deck, outs).round(4)
        probability *= 100
        return "#{probability.to_s}% " 
    elsif table.length == 0 && !my_hand.card_pair?
        return "1.0%"
    elsif table.length > 2 && !my_hand.card_pair?
        return "< 1%"
    elsif table.length == 4 && !my_hand.card_pair?
        return "0.0%"
    elsif my_hand.card_pair?
        card_probabilities = []
        my_hand.cards.each_with_index do |my_card, idx|
            if my_hand.card_pair[idx]
                outs = pair_outs(my_card, table, deck)
                probability = probability_of_success(table, deck, outs).round(4)
                probability *= 100
                card_probabilities << "#{probability}% "
            elsif table.length < 4
                card_probabilities << "< 1.0%"
            else
                card_probabilities << "0.0%"
            end
        end
        return card_probabilities

    else  
        return "Bad Calculation, pls report /logic.rb(83)"
    end
end

def trips?(my_hand, table)
    if my_hand.pocket_pair && table.include_number?(my_hand[0].number)
        my_hand.card_trips = [true, true]
    else 
        counter = [1,1]
        my_hand.cards.each_with_index do |my_card, idx|  
            table.each { |table_card| counter[idx] += 1 if table_card.number == my_card.number }
        end
        counter.each_with_index { |num, idx| my_hand.card_trips[idx] = true if num >= 3 }
    end
    return my_hand.card_trips?
end

def prob_of_flush(my_hand, table, deck)
    outs = []
    my_suit, out_successes = [my_hand.cards, table].flatten.most_suited
    outs = suited_outs(my_suit, table, deck)
    
    if out_successes == 0
        my_hand.flush = true
        return "You have a flush!"

    elsif table.length == 0

        if my_hand.suited 
            probability = 10 * probability_of_one_combination(table, deck, outs, out_successes) + (5 * (11*10*9*8*39)/(50*49*48*47*46)).to_f + (11*10*9*8*7)/(50*49*48*47*46).to_f
            probability = probability.round(4)
            probability *= 100
            probability = probability.round_2
            return "#{probability}%"
        end 
        return "< 1%"
        
    elsif table.length == 3
        if outs.length > 10
            return "0.0%"
        elsif out_successes == 1
            probability = 0.8085 * 0.8043
            probability = 1 - probability.round(4)
            probability *= 100
            return "#{probability}%"
        elsif out_successes == 2
            probability = 0.2128 * 0.1957
            probability = probability.round(4)
            probability *= 100
            return "#{probability}%"
        end

    elsif table.length == 4
        if outs.length > 9
            return "0.0%"
        end
        return "19.57%"
        
    else
        return "0.0%"
    end
end

def suited_outs(my_suit, table, deck)
    outs = []
    deck.each { |deck_card| outs << deck_card if deck_card.suit == my_suit }
    outs
end

def prob_of_fullhouse(my_hand, table, deck)
    my_hand.paired_table = true if table.pair? 
    my_hand.tripd_table = true if table.trip?
    my_hand.fullhouse?(table)

    if my_hand.fullhouse
        return "100%" 

    elsif table.length == 0
        if my_hand.pocket_pair
            return "2.6%"
        else
            return "< 1%"
        end

    elsif table.length == 3
        if !my_hand.card_pair? && !my_hand.paired_table 
            return "0.0%"
        elsif my_hand.card_trips?
            return "24.24%"
        elsif my_hand.both_card_pair? || (my_hand.one_pair? && my_hand.paired_table)
            return "16.47%"
        elsif my_hand.one_pair? || my_hand.paired_table
            return "10.92% ish"
        end

    elsif table.length == 4
        if !my_hand.card_pair? && !my_hand.tripd_table
            return "0.0%"
        elsif my_hand.card_trips?
            return "20%"
        elsif my_hand.both_card_pair?
            return "8.89%"
        elsif my_hand.one_pair? || my_hand.paired_table
            return "0.0%"
        end

    else table.length == 5
        return "You have a Full House" if my_hand.fullhouse 
        return "0.0%"
    end
    
end

def untripd_card(my_hand)
    my_hand.card_trips.each_with_index { |is_trip, idx| return my_hand[idx] if !is_trip }
end

def in_play_cards_counter(cards_arr)
    cards = cards_arr.flatten
    counter = Hash.new(0)
    cards.each { |card| counter[card.number] += 1 }
    return counter
end

def two_pair?(counts)
    pair_counter = 0
    counts.each_value { |count| pair_counter += 1 if count == 2 }
    return pair_counter > 1
end

def add_percentages(arr_of_percentages)
    sum = 0.0
    arr_of_percentages.each do |percentage|
        chars = percentage.split("")
        chars.pop
        percentage = chars.join("").to_f
        sum += percentage 
    end
    return sum
end