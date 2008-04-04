$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "fileutils"
require 'net/http'
require 'timeout'
require 'cgi'
require 'optparse'

begin
  require 'rubygems'
rescue LoadError
end

require 'shared-mime-info' # shared-mime-info rubygem

require "ruby-ext/hash"
require "pastie_packer/io"
require "pastie_packer/options"
require "pastie_packer/conversion"
require "pastie_packer/upload"
require "pastie_packer/fetch"
require "pastie_packer/header"
require "pastie_packer/command"
