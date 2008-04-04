class PastiePacker
  def self.run(args = [])
    packer = PastiePacker.new
    if !(files = packer.input_lines).empty?
      packer.do_pack_files(files)
    elsif args.empty?
      packer.do_pack
    else
      packer.do_unpack(args)
    end
  end

  def do_pack
    packed = self.path_to_string(FileUtils.pwd)
    url = API.new.paste packed if packed && !packed.empty?
  end

  def do_pack_files(files)
    packed = self.files_to_string(files)
    url = API.new.paste packed if packed && !packed.empty?
  end

  def do_unpack(pastie_urls)
    pastie_urls.each do |raw_url|
      url = raw_url.gsub(/\.txt$/,'')
      unique_subfolder = url.match(/\/([^\/]*)$/)[1]
      contents = self.fetch_pastie(url)
      unpack(contents, File.join(FileUtils.pwd, unique_subfolder))
    end
    nil # so nothing is printed as a result
  end
end