module ModifyLink
  def modified_link
    return self.url = nil if self.url.blank?
    unless self.url.include?("http://") || self.url.include?("https://")
      self.url = "http://" + self.url
    end
  end
end
