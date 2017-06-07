require "net/http"

class Api::HttpActionService
  def initialize url, params, auth_token = ""
    @uri = URI url
    @params = params
    @auth_token = auth_token
  end

  def get_data
    @uri.query = URI.encode_www_form @params
    http = Net::HTTP.new(@uri.host, @uri.port).start
    request = Net::HTTP::Get.new(@uri.request_uri,
      "TMS-AUTH-TOKEN": @auth_token)
    http.request request
  rescue StandardError
    false
  end

  def post_data
    Net::HTTP.post_form @uri, @params
  rescue StandardError
    false
  end
end
