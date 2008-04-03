class PastiePacker
  def self.run(args = [])
    packer = PastiePacker.new
    if args.empty?
      packer.do_pack
    else
      packer.do_unpack(args)
    end
  end

  def do_pack
    packed = self.path_to_string(FileUtils.pwd)
    url = API.new.paste packed
  end

  def do_unpack(pastie_urls)
    pastie_urls.each do |raw_url|
      url = raw_url.gsub(/\.txt$/,'')
      contents = self.fetch_pastie(url)
      unpack(contents, FileUtils.pwd)
    end
  end
end