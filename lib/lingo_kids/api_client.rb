require 'net/http'
require 'json'
require 'lingo_kids/retryable'

class LingoKids::ApiClient
  include LingoKids::Retryable

  UnknownError            = Class.new(StandardError)
  RateLimitError          = Class.new(StandardError)
  ServiceUnavailableError = Class.new(StandardError)

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
      with_retries(rate_limit_options) do
        with_retries(service_unavailable_options) do
          uri = URI(API_URL)
          uri.query = URI.encode_www_form(params)
          res = Net::HTTP.get_response(uri)
          case res.code
          when "403"
            raise RateLimitError
          when "503"
            raise ServiceUnavailableError
          when "200"
            res
          else
            raise UnknownError, "#{res.code}\n#{res.to_hash}\n#{res.body}"
          end
        end
      end
  end

  def rate_limit_options
    {
      error: RateLimitError,
      error_message: "Rate Limit Exceeded."
    }
  end

  # I received this error a lot during this afternoon, and it worked if I retried
  # some seconds later, so have decided to control also this one
  def service_unavailable_options
    {
      error: ServiceUnavailableError,
      error_message: "We are temporarily offline for maintenance.",
      seconds: 10
    }
  end
end
