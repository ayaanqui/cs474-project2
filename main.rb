class Project2
  def initialize
  end

  # @param filename String
  # @return Array
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
        puts(get_file_data "pc_input.txt")
      when "s"
        puts "Run one line at a time."
      when "x"
        break
      else
        puts "Unknown command"
      end
    end
  end
end

program = Project2.new
program.program_loop