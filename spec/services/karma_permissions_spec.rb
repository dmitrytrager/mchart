# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleExpectations
RSpec.describe KarmaPermissions do
  subject { described_class.new(karma:) }

  context "when positive karma" do
    let(:karma) { 20 }

    it "gets permissions for karma" do
      expect(subject.permissions).to include(described_class::PERMISSIONS[:karma_vote_negative])
      expect(subject.permissions).not_to include(described_class::PERMISSIONS[:publish_self_pr])
    end
  end

  context "when negative karma" do
    let(:karma) { -15 }

    it "gets permissions for karma" do
      expect(subject.permissions).to include(described_class::PERMISSIONS[:one_per_day])
      expect(subject.permissions).not_to include(described_class::PERMISSIONS[:one_per_hour])
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
