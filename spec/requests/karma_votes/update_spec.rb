# frozen_string_literal: true

require "rails_helper"

describe "PUT /users/:user_id/karma_votes/:id", type: :request do
  let(:user)        { create(:user) }
  let(:user2)       { create(:user) }
  let(:other_user1) { create(:user) }
  let(:other_user2) { create(:user) }
  let(:karma_vote)  { create(:karma_vote, voter_id: user.id, votee_id: user2.id, vote: -1) }
  let(:url)         { "/users/#{user2.id}/karma_votes/#{karma_vote.id}" }

  before do
    create :karma_vote, voter_id: other_user1.id, votee_id: user.id
    create :karma_vote, voter_id: other_user2.id, votee_id: user.id

    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "updates karma vote" do
    put(url)

    expect(karma_vote.reload.vote).to eq(1)
  end

  context "when updating to negative karma" do
    let(:karma_vote) { create(:karma_vote, voter_id: user.id, votee_id: user2.id, vote: 1) }

    it "does not update karma vote" do
      put(url)

      expect(karma_vote.reload.vote).to eq(1)
    end
  end
end
