class Project2
  def initialize
  end

  def program_loop
    while true
      input = gets
      command = input[0]

      case command
      when "r"
        puts "Run the file until the end."
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