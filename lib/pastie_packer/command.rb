class PastiePacker
  attr_accessor :contents
  
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
    self.contents = self.path_to_string(FileUtils.pwd)
    if contents && !contents.empty?
      add_header(File.basename(FileUtils.pwd))
      url = API.new.paste contents
    end
  end

  def do_pack_files(files)
    self.contents = self.files_to_string(files)
    if contents && !contents.empty?
      add_header
      url = API.new.paste contents
    end
  end

  def do_unpack(pastie_urls)
    pastie_urls.each do |raw_url|
      url = raw_url.gsub(/\.txt$/,'')
      unique_subfolder = url.match(/\/([^\/]*)$/)[1]
      self.contents = fetch_pastie(url)
      unpack(File.join(FileUtils.pwd, unique_subfolder))
    end
    nil # so nothing is printed as a result
  end
end