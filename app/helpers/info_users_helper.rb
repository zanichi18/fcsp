module InfoUsersHelper
  def quote_content quote
    (quote && quote.empty?) ? t("users.social_network.add_quote") : quote
  end
end
