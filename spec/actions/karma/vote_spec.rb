# frozen_string_literal: true

require "rails_helper"

RSpec.describe Karma::Vote do
  subject { described_class.new(voter, votee, vote) }

  let(:voter)        { create(:user, karma_points:, karma:) }
  let(:votee)        { create(:user) }
  let(:vote)         { 1 }
  let(:karma_points) { 2 }
  let(:karma)        { 1 }
  let(:created_vote) { votee.karma_votes.find_by(voter_id: voter.id) }

  it "creates new vote for votee and reduces karma points for voter" do
    subject.call

    expect(created_vote).to be_present
    expect(created_vote.vote).to eq(1)
    expect(voter.reload.karma_points).to be_zero
    expect(votee.reload.karma).to eq(1)
  end

  context "when voting for self" do
    let(:votee) { voter }

    it "does not create or update karma vote" do
      subject.call

      expect(created_vote).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when vote is not 1/-1" do
    let(:vote) { 2 }

    it "does not create or update karma vote" do
      subject.call

      expect(created_vote).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when votee has max karma" do
    before do
      votee.update(rating: 0, karma: 4)
      subject.call
    end

    it "does not create or update karma vote" do
      expect(created_vote).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when voter has not enough karma points" do
    before do
      voter.update(karma_points: 1)
      subject.call
    end

    it "does not create or update karma vote" do
      expect(created_vote).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when voter has not enough karma" do
    before do
      voter.update(karma: 0)
      subject.call
    end

    it "does not create or update karma vote" do
      expect(created_vote).to be_nil
      expect(voter.reload.karma_points).not_to be_zero
    end
  end

  context "when karma vote was updated during last day" do
    before do
      votee.karma_votes.create(voter_id: voter.id, vote: -1)
      subject.call
    end

    it "does not create or update karma vote" do
      expect(created_vote).not_to be_nil
      expect(created_vote.vote).to eq(-1)
      expect(voter.reload.karma_points).not_to be_zero
    end
  end
end
