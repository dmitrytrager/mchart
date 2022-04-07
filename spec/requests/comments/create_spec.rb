# frozen_string_literal: true

require "rails_helper"

describe "POST /charts/:chart_id/comments", type: :request do
  let(:user)   { create(:user) }
  let(:chart)  { create(:chart, user:) }
  let(:url)    { "/charts/#{chart.id}/comments" }
  let(:params) { { comment: { text: "text" } } }

  before do
    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "creates comment" do
    post(url, params:)

    expect(chart.reload.comments.size).to eq(1)
  end

  context "when karma is not enough" do
    let!(:comment)   { create(:comment, user:) }
    let(:other_user) { create(:user) }

    before do
      create :karma_vote, voter_id: other_user.id, votee_id: user.id, vote: -1
    end

    it "does not create comment" do
      post(url, params:)

      expect(chart.reload.comments.size).to be_zero
    end
  end
end
