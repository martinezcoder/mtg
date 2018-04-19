require 'spec_helper'

describe Mtg::Card do
  subject { described_class }

  describe "#all" do
    before do
      allow_any_instance_of(Mtg::Downloader)
        .to receive(:all).and_return([:a, :b, :c])
    end

    it "downloads the list of cards" do
      expect(subject.all).to eq [:a, :b, :c]
    end
  end

  describe "#each" do
    before do
      allow_any_instance_of(Mtg::Downloader)
        .to receive(:each).and_yield(:a).and_yield(:b)
      subject.class_variable_set :@@cards, nil
    end

    it "downloads the list of cards" do
      a = []
      subject.each { |c| a << c }
      expect(a).to eq [:a, :b]
    end
  end
end

