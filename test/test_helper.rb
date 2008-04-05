require 'test/unit'
require "rubygems"
require "fileutils"

begin
  require 'mocha'
rescue LoadError
  puts "Install mocha gem to run tests"
  exit
end

require File.dirname(__FILE__) + '/../lib/pastiepacker'

$complete_pastie = <<-EOS
## README.txt
This is the readme.txt


## History.txt
== 1.0.0

* Some history

## lib/myapp.rb
class Myapp

end
EOS


$complete_pastie_and_header = <<-EOS + $complete_pastie
## about:sample_app
Files for sample_app uploaded by pastiepacker.
To unpack files see http://pastiepacker.rubyforge.org

EOS

$complete_pastie_and_header_and_comment = <<-EOS + $complete_pastie
## about:sample_app
This is a bonus comment.

Files for sample_app uploaded by pastiepacker.
To unpack files see http://pastiepacker.rubyforge.org

EOS

$some_files_and_header = <<-EOS
## about:
Files uploaded by pastiepacker.
To unpack files see http://pastiepacker.rubyforge.org

## README.txt
This is the readme.txt


## lib/myapp.rb
class Myapp

end
EOS
