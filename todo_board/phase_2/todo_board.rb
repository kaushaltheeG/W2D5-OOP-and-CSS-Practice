require_relative "./item.rb"
require_relative "./list.rb"


class TodoBoard

    def initialize(label)
        @list = Hash.new #{|h,k| h[k] = List.new(label)}
        @list[label] = List.new(label)
    end

    def get_command
        puts "Enter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            label = args.pop
            @list[label] = List.new(label)
        when 'ls'
            @list.each {|k,v| p k}
        when 'showall'
            @list.each {|k,v| v.print}
        when 'mktodo'
            @list[args[0]].add_item(*args[1..-1])
        when 'up'
            @list[args[0]].up(*args[1..-1])
        when 'down'
            @list[args[0]].down(*args[1..-1])
        when 'swap'
            @list[args[0]].swap(*args[1..-1])
        when 'sort'
            @list[*args].sort_by_date!
        when  'priority'
            @list[*args].print_priority
        when 'print'
            args.length == 1 ? @list[args[0]].print : @list[args[0]].print_full_item(*args[1..-1])
        when 'toggle'
            @list[args[0]].toggle_item(args[1])
        when 'rm'
            @list[args[0]].remove_item(args[1])
        when 'purge'
            @list[args[0]].purge
        when 'quit'
            return false
        else
            puts "Invalid command, please input another command."
        end

        true
    end

    def run
        running = true
        while running
            running = get_command
        end
    end

end

b = TodoBoard.new('groceries')
b.run