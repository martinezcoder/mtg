require 'spec_helper'

describe Mtg do
  subject { described_class }

  describe "#group_by_set" do
    context "api response returns an empty list of cards" do
      let(:cards) { [] }


      it "returns an empty hash" do
        expect(Mtg.group_by_set).to eq({})
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
        expect(Mtg.group_by_set).to eq(
          "khans" => [{"set"=>"khans"}],
          "ktk" => [{"set"=>"ktk"}]
        )
      end
    end
  end
end
