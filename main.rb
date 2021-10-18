class Project2
  def initialize
  end

  # pc_input.txt format style:
  # The syntax of each arithmetic expression conforms to the following four patterns
  # where id can be one of: w, x, y, and z.
  # And op can be one of: +, -, *, **, and /.
  # 1. id = id op id.
  # 2. id = id op constant.
  # 3. id = constant.
  # 4. id ? go int.
  #
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
