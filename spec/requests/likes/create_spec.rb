# frozen_string_literal: true

require "rails_helper"

describe "POST /charts/:chart_id/likes", type: :request do
  let(:user)     { create(:user) }
  let(:chart)    { create(:chart, user:) }
  let(:chart_id) { chart.id }
  let(:url)      { "/charts/#{chart_id}/likes" }

  before do
    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "does not create likes" do
    post(url)

    expect(chart.reload.likes.size).to eq(0)
  end

  context "when having some karma_points" do
    before { user.update(karma_points: 2) }

    it "creates likes" do
      post(url)

      expect(chart.reload.likes.size).to eq(1)
    end
  end
end
