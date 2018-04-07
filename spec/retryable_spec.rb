require 'spec_helper'
require 'lingo_kids/retryable'

class RetryableTest
  include LingoKids::Retryable

  class MyCustomError < StandardError; end

  def test1
    with_retries(2, MyCustomError, 0) do
      raise RuntimeError
    end
  end

  def test2
    with_retries(2, MyCustomError, 0) do
      raise MyCustomError
    end
  end
end

describe LingoKids::Retryable do
  subject { RetryableTest.new }

  context "raising an unexpected error to retry" do
    it "raises Runtime  error" do
      expect { subject.test1 }
        .to raise_error RuntimeError
    end
  end

  context "raising an expected error to retry" do
    it "raise an error after retrying" do
      expect { subject.test2 }
        .to raise_error "Retries Limit Exceeded. Raising..."
    end
  end
end
