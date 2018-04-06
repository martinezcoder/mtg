require 'lingo_kids'

describe LingoKids do
  subject { described_class }

  before do
    allow_any_instance_of(LingoKids::ApiClient).to receive(:cards).and_return(cards)
  end

  context "api response is an empty list of cards" do
    let(:cards) { [] }

    it "returns an empty hash" do
      expect(LingoKids.run).to eq({})
    end
  end

  context "api response is a present list of cards" do
    let(:cards) do
      [
        { "set" => "khans" },
        { "set" => "ktk" }
      ]
    end

    it "returns an empty hash" do
      expect(LingoKids.run).to eq(
        "khans" => [{"set"=>"khans"}],
        "ktk" => [{"set"=>"ktk"}]
      )
    end
  end
end
