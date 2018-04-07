require 'net/http'
require 'json'
require 'lingo_kids/retryable'

class LingoKids::ApiClient
  include LingoKids::Retryable

  API_URL = "https://api.magicthegathering.io/v1/cards"

  attr_reader :params

  def initialize(params={})
    @params = params
  end

  def get(params=nil)
    headers = response.to_hash
    body = JSON.parse(response.body)
    { headers: headers, body: body }
  end

  private

  def response
    @response ||=
      with_retries(3, StandardError, 5) do
        uri = URI(API_URL)
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        raise StandardError if res.code == "403"
        res
      end
  end
end
