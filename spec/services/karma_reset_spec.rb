# frozen_string_literal: true

require "rails_helper"

RSpec.describe KarmaReset do
  subject { described_class.new(user) }

  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:vote)       { create(:karma_vote, voter_id: other_user.id, votee_id: user.id) }

  before do
    expect(user.reload.karma).to eq(1)
  end

  it "resets karma of given user" do
    subject.call

    expect(user.reload.karma).to be_zero
    expect(user.karma_votes).to be_empty
  end
end
