require_relative "./parser"
require_relative "./expression"

class Project2 < Parser
  def initialize
    super(%w[w x y z], %w[= ?], %w[+ - * / **])
  end

  # Returns each line in filename as an element in an array
  # @param filename (String)
  # @return (Array)
  def get_file_data(filename)
    file = File.open filename
    data = file.readlines.map { |line| line.chomp }
    file.close
    data
  end

  def program_loop
    while true
      input = gets
      command = input[0]

      case command
      when "r"
        data = get_file_data "pc_input.txt"
        data.each do |line| 
          parsed_line = parse line
          parsed_line.print
          puts ""
        end
      when "s"
        puts "Run one line at a time."
      when "x"
        break
      else
        puts "Unknown command"
      end

      puts ""
    end
  end
end

program = Project2.new
program.program_loop
