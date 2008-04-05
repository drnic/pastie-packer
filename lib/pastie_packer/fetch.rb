class PastiePacker
  def fetch_pastie(url)
    txt_url = "#{url}.txt"
    # REMOVE: Net::HTTP.get(URI.parse(txt_url))
    open(txt_url)
  end
end
