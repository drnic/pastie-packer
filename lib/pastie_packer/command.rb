class PastiePacker
  def self.run(args = [])
    packed = self.path_to_string(FileUtils.pwd)
    self.post packed
  end
end