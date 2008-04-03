class PastiePacker
  def self.run(args = [])
    packed = self.path_to_string(FileUtils.pwd)
    url = API.new.paste packed
  end
end