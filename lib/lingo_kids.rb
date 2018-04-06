class LingoKids
  def self.run
    client = ApiClient.new
    set = Set.new

    client.cards.each do |c|
      set.add(c["set"], c)
    end

    return set.set
  end
end

require 'lingo_kids/set'
require 'lingo_kids/api_client'
