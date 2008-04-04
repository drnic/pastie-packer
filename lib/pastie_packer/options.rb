class PastiePacker
  attr_reader :format
  attr_accessor :args

  def private?; @private; end

  def parse_options(args)
    @private = false
    @format  = "ruby"

    OptionParser.new do |opts|
      opts.banner = <<BANNER
Prepare to pack or unpack piles of files with the pastie_packer.

To pack a folder: #{File.basename($0)}
To pack some files ending with "txt": find * | grep "txt$" | #{File.basename($0)}
- It outputs the url of the prepared pastie, so you can pipe it to xargs:
- pastie_packer | xargs open

To unpack a packed pastie: #{File.basename($0)} http://pastie.caboo.se/175183
- This unpacks the files into a subfolder 175138/

Options are:
BANNER
      opts.separator ""
      opts.on("-p", "--private",
              "Posted pasties are private",
              "Ignored for unpacking",
              "Default: false") { |x| @private = x }
      opts.on("-f", "--format=FORMAT", String,
              "Possess pasties with a particular persona",
              "Supported formats:",
              AVAILABLE_PARSERS.join(', '),
              "Ignored for unpacking",
              "Default: ruby") { |x| @format = x }
      opts.on("-h", "--help",
              "Show this help message.") { puts opts; exit }
      self.args = opts.parse!(args)
    end
  end
end