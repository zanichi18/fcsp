module ModifyLink
  def modified_link
    unless self.url.include?("http://") || self.url.include?("https://")
      self.url = "http://" + self.url
    end
  end
end
