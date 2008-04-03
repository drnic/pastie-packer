require "tempfile"

class PastiePacker
  def self.post(contents)
    text_file = Tempfile.open("w+")
    text_file << contents
    text_file.flush
    paste_url = 'http://pastie.caboo.se/pastes/create'
    cmd = "curl #{paste_url}     -s -L -o /dev/null -w \"%{url_effective}\"     -H \"Expect:\"     -F \"paste[parser]=ruby\"     -F \"paste[restricted]=0\"     -F \"paste[authorization]=burger\"     -F \"paste[body]=<#{text_file.path}\"     -F \"key=\"     -F \"x=27\"     -F \"y=27\"\n"
    url = `\n      #{cmd}\n    `
    text_file.close(true)
    url
  end
end
