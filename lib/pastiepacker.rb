$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "fileutils"
require 'net/http'
require 'timeout'
require 'cgi'
require 'optparse'
require "open-uri"

begin
  require 'rubygems'
rescue LoadError
end

require 'shared-mime-info' # shared-mime-info rubygem
require 'hpricot'

require "ruby-ext/hash"
require "pastiepacker/io"
require "pastiepacker/options"
require "pastiepacker/conversion"
require "pastiepacker/upload"
require "pastiepacker/fetch"
require "pastiepacker/header"
require "pastiepacker/command"
