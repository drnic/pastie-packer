class PastiePacker
  def fetch_pastie(url)
    txt_url = "#{url}.txt"
    Net::HTTP.get(URI.parse(txt_url))
  end
end
