require_relative "./item.rb"

class List 

    attr_accessor :label

    def initialize(label)
        @label = label
        @item = []
    end


    def add_item(title, deadline, description='')
        valid = Item.valid_date?(deadline)
        return valid if !valid

        @item << Item.new(title, deadline, description)
        valid
    end

    def size
        @item.length
    end

    def valid_index?(idx)
        idx = idx.to_i
        idx >= 0 && idx < size
    end

    def swap(idx_1, idx_2)
        idx_1, idx_2 = idx_1.to_i, idx_2.to_i
        return false if !valid_index?(idx_1) || !valid_index?(idx_2)
        @item[idx_1], @item[idx_2] = @item[idx_2], @item[idx_1]
        true
    end

    def [](idx)
        return nil if !valid_index?(idx)
        @item[idx]
    end

    def priority
        @item[0]
    end

    def print
        puts '----------------------------------------------'
        puts "               #{@label}                      "
        puts '----------------------------------------------'
        puts 'Index | Item                   | Dealine  '
        puts '----------------------------------------------'
        @item.each.with_index do |item, i|
            i = i.to_s.ljust(5)
            task = item.title.ljust(22)
            puts "#{i} | #{task} | #{item.deadline}"
        end
        puts '----------------------------------------------'
    end

    def print_full_item(idx)
        idx = idx.to_i
        return p "Invalid Idx" if !valid_index?(idx)
        task = self[idx]
        puts '----------------------------------------------'
        puts "#{task.title.ljust(30)} #{task.deadline}"
        puts "#{task.description}"
        puts '----------------------------------------------'
    end

    def print_priority
        print_full_item(0)
    end

    def up(idx, amt=1)
        idx = idx.to_i
        
        return false if !valid_index?(idx)
        task = @item[idx]

        i = 0
        while i < amt.to_i
            @item[idx], @item[idx-1] = @item[idx-1], @item[idx]
            i += 1
            @item.index(task) == 0 ? break : idx = @item.index(task)
        end
        true
    end

    def down(idx, amt=1)
        idx = idx.to_i
        return false if !valid_index?(idx)
        task = @item[idx]

        i = amt
        while i > 0
            @item[idx], @item[idx+1] = @item[idx+1], @item[idx]
            i -= 1
            @item.index(task) == size-1 ? break : idx = @item.index(task)
        end
        true
    end

    def sort_by_date!
        @item.sort_by! {|task| task.deadline}
    end
end



