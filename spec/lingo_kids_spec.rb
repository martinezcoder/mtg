require 'spec_helper'

describe LingoKids do
  subject { described_class }

  before do
    LingoKids::Card.class_variable_set :@@cards, cards
  end

  describe "#group_by_set" do
    context "api response returns an empty list of cards" do
      let(:cards) { [] }


      it "returns an empty hash" do
        expect(LingoKids.group_by_set).to eq({})
      end
    end

    context "api response returns a list of present cards" do
      let(:cards) do
        [
          { "set" => "khans" },
          { "set" => "ktk" }
        ]
      end

      it "returns an empty hash" do
        expect(LingoKids.group_by_set).to eq(
          "khans" => [{"set"=>"khans"}],
          "ktk" => [{"set"=>"ktk"}]
        )
      end
    end
  end
end
