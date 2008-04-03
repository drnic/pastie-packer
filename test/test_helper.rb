require 'test/unit'
require "rubygems"
require "fileutils"

begin
  require 'mocha'
rescue LoadError
  puts "Install mocha gem to run tests"
  exit
end

require File.dirname(__FILE__) + '/../lib/pastie_packer'

COMPLETE_PASTIE = <<-EOS
## README.txt
This is the readme.txt


## lib/myapp.rb
class Myapp

end
EOS