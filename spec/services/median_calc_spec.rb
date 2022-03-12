# frozen_string_literal: true

require "rails_helper"

RSpec.describe MedianCalc do
  subject { described_class.new(list) }

  context "list is present" do
    let(:list) { [1, 3, 5, 7, 9] }

    it "returns median" do
      expect(subject.median).to eq(5)
    end
  end
end
