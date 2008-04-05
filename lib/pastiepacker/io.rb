class PastiePacker
  def input_stream
    $stdin
  end

  def output_stream
    $stdout
  end

  def input_lines
    if !input_stream.tty?
      input_stream.readlines
    else
      []
    end
  end
end