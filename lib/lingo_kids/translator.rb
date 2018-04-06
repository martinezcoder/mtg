class LingoKids::Translator
  def initialize(language)
    @language = language
  end

  def hi
    case @language
    when "spanish"
      "Hola lingo_kids"
    else
      "Hello lingo_kids"
    end
  end
end

