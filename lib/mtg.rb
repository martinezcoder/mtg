class Mtg
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

  def self.ktk_cards
    colors = ["Red", "Blue"]
    cards = Card.where(setName: "Khans of Tarkir", colors: colors.join(","))
    cards.select { |c| c["colors"].size == colors.size }
  end
end

require 'mtg/retryable'
require 'mtg/mtg_set'
require 'mtg/api_client'
require 'mtg/card'
require 'mtg/downloader'
