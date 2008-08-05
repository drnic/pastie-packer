class PastiePacker
  def fetch_pastie(url)
    txt_url = "#{url}.txt"
    open(txt_url)
  end
end
