# frozen_string_literal: true

require "rails_helper"

describe "DELETE /charts/:chart_id/comments/:id", type: :request do
  let(:user)     { create(:user) }
  let(:chart)    { create(:chart, user:) }
  let(:url)      { "/charts/#{chart.id}/comments/#{comment.id}" }
  let!(:comment) { create(:comment, user:, chart:) }

  before do
    user.update(confirmed_at: Time.zone.now)
    sign_in(user)
  end

  it "deletes comment" do
    expect(chart.reload.comments.size).to eq(1)
    delete(url)

    expect(chart.reload.comments.size).to be_zero
  end
end
