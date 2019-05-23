class Array
    def include_id?(id)
        self.each do |card|
            if card.id == id 
                return true
            end
        end
        false
    end

    def include_number?(number)
        self.each do |card| 
            if card.number == number 
                return true
            end
        end
        false
    end

    def include_suit?(suit)
        self.each do |card|
            return true if card.suit == suit 
        end
        false
    end

    def most_suited
        suit_counter = Hash.new(0)
        self.each { |card| suit_counter[card.suit] += 1 }
        highest_suit = nil
        highest_count = 0

        
        suit_counter.each do |suit, count|
            if highest_suit == nil || count > highest_count
                highest_suit = suit 
                highest_count = count
            end
        end

        out_successes = 5 - highest_count
        return [highest_suit, out_successes]
    end

    def pair?
        counter = Hash.new(0)
        self.each { |card| counter[card.number] += 1 }
        counter.any? { |k,v| v == 2 }
    end

    def trip?
        counter = Hash.new(0)
        self.each { |card| counter[card.number] += 1 }
        counter.any? { |k,v| v == 3 }
    end

    def at_least?(num, arr = [], &prc)
        counter = 0
        already_seen = Hash.new(true)
        prc ||= Proc.new { |n| arr.include?(n) }
        self.each do |ele| 
            if prc.call(ele) && !already_seen.key?(ele)
                counter += 1 
                already_seen[ele] = true
            end
        end

        counter >= num 
    end

end

class Float
    def round_2
        my_f = self.to_s
        arr = my_f.split(".")
        arr[1] = arr[1][0...2]
        my_f = arr.join(".")
        return my_f.to_f 
        
    end
end