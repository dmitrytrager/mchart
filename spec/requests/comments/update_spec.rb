# frozen_string_literal: true

require "rails_helper"

describe "PUT /charts/:chart_id/comments/:id", type: :request do
  let(:user)    { create(:user) }
  let(:chart)   { create(:chart, user:) }
  let(:url)     { "/charts/#{chart.id}/comments/#{comment.id}" }
  let(:comment) { create(:comment, user:, chart:) }

  before do
    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "updates comment" do
    patch(url, params: { comment: { text: "new text" } })

    expect(chart.reload.comments.size).to eq(1)
    expect(chart.comments.last.text).to eq("new text")
  end
end
