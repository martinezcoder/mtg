require 'lingo_kids'

# This class prevents to download the cards more than one time
# It will save the cards list in the class variable @@cards
#
class LingoKids::Card
  @@cards = nil

  # TODO: extract to initialized as `downloader :cards`
  def self.downloader
    LingoKids::Downloader.new("cards")
  end

  def self.where(params)
    downloader.where(params)
  end

  def self.all
    @@cards ||= downloader.all
  end

  def self.each
    if @@cards
      @@cards.each do |card|
        yield card
      end
    else
      each_with_download do |card|
        yield card
      end
    end
  end

  def self.each_with_download
    @@cards = []
    downloader.each do |card|
      @@cards << card
      yield card
    end
  end
end
