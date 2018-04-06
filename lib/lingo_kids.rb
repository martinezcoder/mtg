class LingoKids
  def self.hi(language = "english")
    translator = Translator.new(language)
    translator.hi
  end
end

require 'lingo_kids/translator'
