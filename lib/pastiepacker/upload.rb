class PastiePacker
  AVAILABLE_PARSERS = %w(
    actionscript c++ css diff html_rails html 
    java javascript
    php plain_text python
    objective-c++
    ruby ruby_on_rails sql
    shell-unix-generic
  )

  def do_paste
    if to_stdout?
      output_stream.puts contents
    else
      url = API.new.paste contents, format, private?
    end
  end

  class API
    PASTIE_URI = 'pastie.caboo.se'

    def paste(body, format='ruby', is_private=false)
      raise InvalidParser unless valid_parser?(format)
      http = Net::HTTP.new(PASTIE_URI)
      query_string = { :paste => {
        :body => CGI.escape(body),
        :parser => CGI.escape(format),
        :restricted => is_private,
        :authorization => 'burger'
      }}.to_query_string
      resp, body = http.start { |http|
        http.post('/pastes', query_string)
      }
      if resp.code == '302'
        return resp['location']
      else
        raise Error, "#{resp.code} - #{query_string.inspect} - #{resp.inspect}"
      end
    end

    private
      def valid_parser?(format)
        PastiePacker::AVAILABLE_PARSERS.include?(format)
      end
  end

  class Error < StandardError; end
  class InvalidParser < StandardError; end

end

#
# irb(main):002:0> y = `file ~/Pictures/ryandavis2.jpg README.txt`
# => "/Users/nicwilliams/Pictures/ryandavis2.jpg: JPEG image data, JFIF standard 1.01\nREADME.txt:                                 ASCII English text\n"
# irb(main):003:0> YAML.load(y)
# => {"/Users/nicwilliams/Pictures/ryandavis2.jpg"=>"JPEG image data, JFIF standard 1.01", "README.txt"=>"ASCII English text"}
# irb(main):004:0> YAML.load(y).keys
# => ["/Users/nicwilliams/Pictures/ryandavis2.jpg", "README.txt"]
# file --mime ~/Pictures/ryandavis2.jpg README.txt