require 'spec_helper'

describe LingoKids::Set do
  subject { described_class.new }

  describe "#add" do
    before do
      subject.add("X", {name: "card A"})
      subject.add("Y", {name: "card B"})
      subject.add("X", {name: "card C"})
    end

    it "adds new cards to the group" do
      expect(subject.set["X"]).to eq [{name: "card A"}, {name: "card C"}]
      expect(subject.set["Y"]).to eq [{name: "card B"}]
    end
  end
end

