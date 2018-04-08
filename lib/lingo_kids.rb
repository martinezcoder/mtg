class LingoKids
  def self.run
    set = Set.new

    Card.each do |c|
      set.add(c["set"], c)
    end

    return set.set
  end
end

require 'lingo_kids/retryable'
require 'lingo_kids/set'
require 'lingo_kids/api_client'
require 'lingo_kids/card'
require 'lingo_kids/downloader'
