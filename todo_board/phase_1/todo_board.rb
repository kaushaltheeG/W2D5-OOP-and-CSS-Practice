require_relative "./item.rb"
require_relative "./list.rb"


class TodoBoard

    def initialize(label)
        @list = List.new(label)
    end

    def get_command
        puts "Enter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mktodo'
            @list.add_item(*args)
        when 'up'
            @list.up(*args)
        when 'down'
            @list.down(*args)
        when 'swap'
            @list.swap(*args)
        when 'sort'
            @list.sort_by_date!
        when  'priority'
            @list.print_priority
        when 'print'
            args.empty? ? @list.print : @list.print_full_item(*args)
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