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