class PastiePacker
  def path_to_string(path)
    output = ""
    FileUtils.cd path do
      output = files_to_string Dir['**/*'].sort
    end
    output
  end

  def files_to_string(files)
    output = files.inject([]) do |mem, file|
      file = file.strip
      if File.file?(file)
        mem << "## #{file}"
        if ascii? file
          mem << File.open(file, 'r').read
        else
        end
        mem << ""
      end
      mem
    end.join("\n")
    output
  end

  def unpack(target_path)
    FileUtils.rm_rf "#{target_path}/*" # destroys previously unpacked pastie with same id
    FileUtils.mkdir_p target_path
    FileUtils.cd target_path do
      files_contents = contents.split(/^## /)[1..-1] # ignore first ""
      files_contents.each do |file_contents|
        file_name, contents = file_contents.match(/([^\n]+)\n(.*)/m)[1,2]
        if file_name =~ /about:/
          # ignoring header
        else
          contents = contents.gsub(/\n\Z/,'')
          FileUtils.mkdir_p File.dirname(file_name)
          File.open(file_name, "w") do |f|
            f << contents
          end
        end
      end
    end
    target_path
  end

  protected
  def ascii?(file)
    MIME.check(file) == 'text/plain'
  end
end