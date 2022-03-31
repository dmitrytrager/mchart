# frozen_string_literal: true

require "rails_helper"

describe "POST /charts/:chart_id/likes", type: :request do
  let(:user)     { create(:user) }
  let(:chart)    { create(:chart, user:) }
  let(:chart_id) { chart.id }
  let(:url)      { "/charts/#{chart_id}/likes" }

  it "creates likes" do
    post(url, params: {}, headers: {})

    expect(chart.reload.likes.size).to eq(1)
  end
end
