# frozen_string_literal: true

require "rails_helper"

RSpec.describe Likes::Vote do
  subject { described_class.new(voter, voteable) }

  let(:voter)        { create(:user, karma_points:) }
  let(:user)         { create(:user) }
  let(:karma_points) { 1 }
  let(:voteable)     { create(:chart, user:) }
  let(:created_like) { voteable.likes.find_by(voter_id: voter.id) }

  it "creates new like for voteable and reduces karma points for voter" do
    subject.call

    expect(created_like).to be_present
    expect(voter.reload.karma_points).to be_zero
  end

  context "when voteable created long ago" do
    before do
      voteable.update(created_at: 40.days.ago)
      subject.call
    end

    it "does not create new like" do
      expect(created_like).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when voter has not enough karma points" do
    before do
      voter.update(karma_points: 0)
      subject.call
    end

    it "does not create new like" do
      expect(created_like).to be_nil
      expect(voter.reload.karma_points).to be_zero
    end
  end

  context "when like already exists" do
    before do
      voteable.likes.create(voter_id: voter.id)
      subject.call
    end

    it "does not create new like" do
      expect(created_like).to be_present
      expect(voteable.likes.count).to eq(1)
      expect(voter.reload.karma_points).not_to be_zero
    end
  end
end
