class LingoKids
  def self.group_by_set
    set = MtgSet.new

    Card.each do |c|
      set.add(c["set"], c)
    end

    return set.set
  end

  def self.group_by_set_and_rarity
    group_by_set.each_with_object({}) do |(group, value), result|
      result[group] = value.group_by { |v| v["rarity"] }
    end
  end
end

require 'lingo_kids/retryable'
require 'lingo_kids/mtg_set'
require 'lingo_kids/api_client'
require 'lingo_kids/card'
require 'lingo_kids/downloader'
