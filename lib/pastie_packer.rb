$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "fileutils"

class PastiePacker
  def self.path_to_string(path)
    output = ""
    FileUtils.cd path do
      files = Dir['**/*'].sort
      output = files.inject([]) do |mem, file|
        if File.file?(file)
          mem << "## #{file}"
          mem << File.open(file, 'r').read
          mem << ""
        end
        mem
      end.join("\n")
    end
    output
  end
end