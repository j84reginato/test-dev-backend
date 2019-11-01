require 'uri'
require 'net/https'
require 'json'
require "time"

class RequestSenderService
  def post(body)
    uri = URI.parse("https://delivery-center-recruitment-ap.herokuapp.com/")
    req = Net::HTTP::Post.new(uri.to_s)
    req.body = body.to_json
    req['Content-Type'] = 'application/json'
    req['X-Sent'] = request_date

    response = https(uri).request(req)
    response.body
  end

  private

  def request_date
    DateTime.parse(Time.now.to_s).strftime("%Hh%M - %d/%m/%C")
  end

  def https(uri)
    Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end
end
