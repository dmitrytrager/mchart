# frozen_string_literal: true

require "rails_helper"

describe "POST /users/:user_id/karma_votes", type: :request do
  let(:user)        { create(:user) }
  let(:user2)       { create(:user) }
  let(:other_user1) { create(:user) }
  let(:other_user2) { create(:user) }
  let(:vote)        { 1 }
  let(:url)         { "/users/#{user2.id}/karma_votes" }
  let(:params)      { { karma_vote: { vote: } } }

  before do
    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "does not create karma vote" do
    post(url, params:)

    expect(user2.reload.karma_votes.size).to eq(0)
  end

  context "when enough karma and karma points" do
    before do
      create :karma_vote, voter_id: other_user1.id, votee_id: user.id
      create :karma_vote, voter_id: other_user2.id, votee_id: user.id
      user.update(karma_points: 2)
    end

    it "creates karma vote" do
      post(url, params:)

      expect(user2.reload.karma_votes.size).to eq(1)
    end

    context "when vote is negative" do
      let(:vote) { -1 }

      it "does not create karma vote" do
        post(url, params:)

        expect(user2.reload.karma_votes.size).to eq(0)
      end
    end
  end
end
