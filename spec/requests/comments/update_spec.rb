# frozen_string_literal: true

require "rails_helper"

describe "PUT /charts/:chart_id/comments/:id", type: :request do
  let(:user)     { create(:user) }
  let(:chart)    { create(:chart, user:) }
end
