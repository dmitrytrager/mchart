# frozen_string_literal: true

require "rails_helper"

describe "POST /charts/:chart_id/comments", type: :request do
  let(:user)     { create(:user) }
  let(:chart)    { create(:chart, user:) }
end
