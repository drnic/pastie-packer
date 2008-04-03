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
  
  def self.unpack(string, target_path)
    FileUtils.rm_rf target_path # unique pastie-number-based folder shouldn't be there; its not my fault!!!
    FileUtils.mkdir_p target_path
    FileUtils.cd target_path do
      files_contents = string.split(/^## /)[1..-1] # ignore first ""
      files_contents.each do |file_contents|
        file_name, contents = file_contents.match(/([^\n]+)\n(.*)/m)[1,2]
        contents = contents.gsub(/\n\Z/,'')
        base_name, *dirname = file_name.split('/').reverse
        dirname = dirname.join('/')
        FileUtils.mkdir_p dirname if dirname.length > 0
        File.open(file_name, "w") do |f|
          f << contents
        end
      end
    end
    target_path
  end
end