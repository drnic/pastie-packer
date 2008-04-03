require "tempfile"
require 'net/http'
require 'timeout'
require 'cgi'

class PastiePacker
  AVAILABLE_PARSERS = %w(
    c diff html javascript
    nitro_xhtml pascal plaintext
    rhtml ruby sql
  )

  class API
    PASTIE_URI = 'pastie.caboo.se'

    def paste(body, format='ruby', is_private=false)
      raise InvalidParser unless valid_parser?(format)
      http = Net::HTTP.new(PASTIE_URI)
      query_string = { :paste => {
        :body => CGI.escape(body),
        :parser => format,
        :restricted => is_private,
        :authorization => 'burger'
      }}.to_query_string
      resp, body = http.start { |http|
        http.post('/pastes', query_string)
      }
      if resp.code == '302'
        return resp['location']
      else
        raise Pastie::Error
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

# class PastiePacker
#   def self.post(contents)
#     # puts contents
#     # return "foo"
#     text_file = Tempfile.open("w+")
#     text_file << contents
#     text_file.flush
#     paste_url = 'http://pastie.caboo.se/pastes/create'
#     cmd = "curl #{paste_url}     -s -L -o /dev/null -w \"%{url_effective}\"     -H \"Expect:\"     -F \"paste[parser]=ruby\"     -F \"paste[restricted]=0\"     -F \"paste[authorization]=burger\"     -F \"paste[body]=<#{text_file.path}\"     -F \"key=\"     -F \"x=27\"     -F \"y=27\"\n"
#     url = `\n      #{cmd}\n    `
#     text_file.close(true)
#     url
#   end
# end
# 
