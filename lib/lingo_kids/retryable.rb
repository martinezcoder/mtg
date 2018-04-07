module LingoKids::Retryable
  def with_retries(retries, error, seconds)
    @retries = 0
    yield
  rescue error
    puts "Rate Limit Exceeded. Retrying call in #{seconds} seconds"
    if @retries >= retries
      raise "Retries Limit Exceeded. Raising..."
    else
      with_retries(retries, error, seconds) do
        @retries += 1
        sleep seconds
        yield
      end
    end
  end
end
