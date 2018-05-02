module Mtg::Retryable
  # Given an error class,
  # if that error occurs inside the block,
  # it will sleep n seconds
  # and retry the block n times
  #

  def with_retries(options={})
    options = default_retryable_options.update(options)

    max_retries   = options[:retries]
    error         = options[:error]
    sleep_seconds = options[:seconds]
    msg           = options[:error_message]
    current_retry = options[:next_retry]

    yield
  rescue error
#    puts "#{msg}\n Retrying call in #{sleep_seconds} seconds"
    if current_retry >= max_retries
      raise "Retries Limit Exceeded. Raising..."
    else
      with_retries(options.merge(next_retry: current_retry + 1)) do
        sleep sleep_seconds
        yield
      end
    end
  end

  def default_retryable_options
    {retries: 3, error: StandardError, seconds: 5, next_retry: 0}
  end
end
