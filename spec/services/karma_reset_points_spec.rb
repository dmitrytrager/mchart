# frozen_string_literal: true

require "rails_helper"

RSpec.describe KarmaResetPoints do
  let!(:user)        { create(:user) }
  let!(:other_user1) { create(:user) }
  let!(:other_user2) { create(:user) }

  before do
    create :karma_vote, voter_id: other_user1.id, votee_id: user.id
    create :karma_vote, voter_id: other_user2.id, votee_id: user.id
  end

  it "updates evety user's karma points with karma value" do
    subject.call

    expect(user.reload.karma_points).to eq(2)
    expect(other_user1.reload.karma_points).to be_zero
    expect(other_user2.reload.karma_points).to be_zero
  end
end
