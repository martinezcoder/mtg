require 'spec_helper'

describe LingoKids::Card do
  subject { described_class }

  after do
    LingoKids::Card.class_variable_set :@@cards, nil
  end

  describe "#all" do
    before do
      allow_any_instance_of(LingoKids::Downloader)
        .to receive(:all).and_return([:a, :b, :c])
    end

    context "@@cards is nil" do
      before do
        subject.class_variable_set :@@cards, nil
      end

      it "downloads the list of cards" do
        expect(subject.all).to eq [:a, :b, :c]
      end
    end

    context "@@cards contains a list of cards" do
      before do
        subject.class_variable_set :@@cards, [1, 2, 3]
      end

      it "does not download again the listt of cards" do
        expect(subject.all).to eq [1, 2, 3]
      end
    end
  end

  describe "#each" do
    before do
      allow_any_instance_of(LingoKids::Downloader)
        .to receive(:each).and_yield(:a).and_yield(:b)
    end

    context "@@cards is nil" do
      before do
        subject.class_variable_set :@@cards, nil
      end

      it "downloads the list of cards" do
        a = []
        subject.each { |c| a << c }
        expect(a).to eq [:a, :b]
      end
    end

    context "@@cards contains a list of cards" do
      before do
        subject.class_variable_set :@@cards, [1, 2, 3]
      end

      it "does not download again the listt of cards" do
        a = []
        subject.each { |c| a << c }
        expect(a).to eq [1, 2, 3]
      end
    end
  end
end

