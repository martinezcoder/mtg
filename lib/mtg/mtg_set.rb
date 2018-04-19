class Mtg::MtgSet

  attr_reader :set

  def initialize
    @set = Hash.new
  end

  def add(set_name, card)
    set[set_name] ||= []
    set[set_name] << card
  end
end
