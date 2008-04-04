class PastiePacker
  def add_header(title=nil)
    self.contents = header(title) + self.contents
  end

  protected
  def header(title=nil)
    if title
      <<-EOS
## about:#{title}
Files for #{title} uploaded by pastie_packer.
To unpack files see http://pastiepacker.rubyforge.org
EOS
    else
      <<-EOS
## about:
Files uploaded by pastie_packer.
To unpack files see http://pastiepacker.rubyforge.org
EOS
    end
  end
end