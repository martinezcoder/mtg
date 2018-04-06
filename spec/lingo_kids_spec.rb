require 'lingo_kids'

describe LingoKids do
  subject { described_class }

  context "with spanish language" do
    let(:language) { "spanish" }

    it "greets in spanish" do
      expect(subject.hi(language)).to eq "Hola lingo_kids"
    end
  end

  context "with another language" do
    let(:language) { "mandarin" }

    it "greets in english" do
      expect(subject.hi(language)).to eq "Hello lingo_kids"
    end
  end
end
