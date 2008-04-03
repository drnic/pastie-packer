$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "fileutils"
require 'net/http'
require 'timeout'
require 'cgi'


require "ruby-ext/hash"
require "pastie_packer/conversion"
require "pastie_packer/upload"
require "pastie_packer/command"
