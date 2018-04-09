require 'net/http'
require 'json'
require 'lingo_kids/retryable'

class LingoKids::ApiClient
  include LingoKids::Retryable

  RateLimitError = Class.new(StandardError)

  API_URL = "https://api.magicthegathering.io/v1/cards"

  attr_reader :params

  def get(params={})
    @params = params
    headers = response.to_hash
    body = JSON.parse(response.body)
    { headers: headers, body: body }
  end

  private

  def response
    @response ||=
      with_retries({error: RateLimitError}) do
        uri = URI(API_URL)
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        raise RateLimitError if res.code == "403"
        res
      end
  end
end
