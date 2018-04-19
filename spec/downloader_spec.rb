require 'spec_helper'

describe Mtg::Downloader do
  subject { described_class.new("cards") }

  describe "#all" do
    context "one page with cards" do
      before do
        allow_any_instance_of(Mtg::ApiClient)
          .to receive(:get).with({})
          .and_return(response)
      end

      let(:response) do
        {
          headers: { "link" => ["<http://test?page=1>; rel=\"last\""] },
          body: { "cards" => cards }
        }
      end

      let(:cards) do
        [ { "name" => "A" }, { "name" => "B" } ]
      end

      it "returns all the cards" do
        expect(subject.all).to eq(cards)
      end
    end

    context "multiple pages with cards" do
      before do
        allow_any_instance_of(Mtg::ApiClient)
          .to receive(:get).with({})
          .and_return(response1)

        allow_any_instance_of(Mtg::ApiClient)
          .to receive(:get).with(page: 2)
          .and_return(response2)
      end

      let(:headers) do
        { "link" => ["<http://test?page=2>; rel=\"last\""] }
      end

      let(:response1) do
        { headers: headers, body: { "cards" => cards1 } }
      end

      let(:response2) do
        { headers: headers, body: { "cards" => cards2 } }
      end

      let(:cards1) do
        [ { "name" => "A" }, { "name" => "B" } ]
      end

      let(:cards2) do
        [ { "name" => "C" }, { "name" => "D" } ]
      end

      it "returns array of cards from all pages" do
        expect(subject.all).to eq(cards1 + cards2)
      end
    end
  end

  describe "#each" do
    # all method uses each, so it is indirectly tested
  end
end

