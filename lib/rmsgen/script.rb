class Rmsgen::Script
  EXPIRY = "What day does it expire? ex) 08 July 2011:\n "
  TEXT   = "What is the text?"

  def initialize(stdout=$stdout)
    @stdout = stdout
  end

  def prompt_for_expiry_date
    prompt EXPIRY
  end

  def prompt_for_text
    prompt TEXT
  end

  def prompt_for_polnote_link(part)
    label = part[1..-2] + ":\n"
    @stdout.puts label
    @stdout.puts
    prompt(label)
  end

  def prompt(label)
    @stdout.puts label
    @stdout.puts
    input = $stdin.gets.chomp
    @stdout.puts
    input
  end

  def prompt_for_title
    @stdout.puts "Type title:"
    @stdout.puts
    input = $stdin.gets.chomp
    @stdout.puts
    input
  end

  def say(last)
    @stdout.puts last
    @stdout.puts
  end
end
