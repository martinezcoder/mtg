require 'net/http'
require 'json'

class LingoKids::ApiClient
  API_URL = "https://api.magicthegathering.io/v1/cards"

  def cards
    # TODO: loop pages
    JSON.parse(response.body)["cards"]
  end

  private

  def response
    Net::HTTP.get_response(uri)
  end

  def uri
    URI(API_URL)
  end
end
