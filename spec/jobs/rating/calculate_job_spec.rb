# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Rating::CalculateJob, type: :job do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }

  let!(:chart1) { create(:chart, user:) }
  let!(:chart2) { create(:chart, user:) }
  let!(:chart3) { create(:chart, user:) }
  let!(:chart4) { create(:chart, user:) }
  let!(:chart5) { create(:chart, user:) }

  let!(:comment1) { create(:comment, chart: chart1, user:) }
  let!(:comment2) { create(:comment, chart: chart1, user:) }
  let!(:comment3) { create(:comment, chart: chart1, user:) }
  let!(:comment4) { create(:comment, chart: chart1, user:) }
  let!(:comment5) { create(:comment, chart: chart1, user:) }

  let!(:chart1_likes) { create_list(:like, 3, voter: other_user, voteable: chart1) }
  let!(:chart2_likes) { create_list(:like, 2, voter: other_user, voteable: chart2) }

  let!(:comment1_likes) { create_list(:like, 7, voter: other_user, voteable: comment1) }
  let!(:comment2_likes) { create_list(:like, 6, voter: other_user, voteable: comment2) }
  let!(:comment3_likes) { create_list(:like, 5, voter: other_user, voteable: comment3) }
  let!(:comment4_likes) { create_list(:like, 2, voter: other_user, voteable: comment4) }

  it "updates user with median rating with no penalty" do
    subject.perform

    expect(user.reload.rating).to eq(2)
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
