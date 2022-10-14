class Item
    attr_accessor :title, :description
    attr_reader :deadline

    def self.valid_date?(date_string)
        return false if date_string.length != 10
        year = date_string[0..3].to_i
        month = date_string[5..6].to_i
        day = date_string[8..9].to_i
        return false if year.to_s.length != 4
        
        (1..12).to_a.include?(month) && (1..31).to_a.include?(day)
    end

    def initialize(title, deadline, description)
        @title, @deadline, @description = title, deadline, description
        raise ArgumentError.new "Invalide Date for Dealine, date should be strutuced as such: YYYY-MM-DD" if !Item.valid_date?(@deadline)
    end

    def deadline=(new_date)
        @deadline = new_date if Item.valid_date?(new_date)
        raise ArgumentError.new "Invalide Date for Dealine, date should be strutuced as such: YYYY-MM-DD" if !Item.valid_date?(new_date)
    end


end

