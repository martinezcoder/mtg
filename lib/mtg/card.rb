require 'mtg'

# This class prevents to download the cards more than one time
# It will save the cards list in the class variable @@cards
#
class Mtg::Card
  def self.downloader
    Mtg::Downloader.new("cards")
  end

  def self.where(params)
    downloader.where(params)
  end

  def self.all
    downloader.all
  end

  def self.each
    downloader.each do |card|
      yield card
    end
  end
end
