# frozen_string_literal: true

require "rails_helper"

RSpec.describe KarmaResetPoints do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    user.update(karma: 4)
  end

  it "updates evety user's karma points with karma value" do
    subject.call

    expect(user.reload.karma_points).to eq(4)
    expect(other_user.reload.karma_points).to be_zero
  end
end
