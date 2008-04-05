class PastiePacker
  def add_header(title=nil)
    self.contents = header(title) + self.contents
  end

  protected
  def header(title=nil)
    message = extra_message ? "#{extra_message}\n\n" : ""
    if title
      <<-EOS
## about:#{title}
#{message}Files for #{title} uploaded by pastiepacker.
To unpack files see http://pastiepacker.rubyforge.org

EOS
    else
      <<-EOS
## about:
#{message}Files uploaded by pastiepacker.
To unpack files see http://pastiepacker.rubyforge.org

EOS
    end
  end
end