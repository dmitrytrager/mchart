# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe MedianRating do
  subject { described_class.new(user.charts, user.comments).call }

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

  context "when charts and comments have some likes" do
    let!(:chart1_likes) { create_list(:like, 3, voter: other_user, voteable: chart1) }
    let!(:chart2_likes) { create_list(:like, 2, voter: other_user, voteable: chart2) }

    let!(:comment1_likes) { create_list(:like, 7, voter: other_user, voteable: comment1) }
    let!(:comment2_likes) { create_list(:like, 6, voter: other_user, voteable: comment2) }
    let!(:comment3_likes) { create_list(:like, 5, voter: other_user, voteable: comment3) }
    let!(:comment4_likes) { create_list(:like, 2, voter: other_user, voteable: comment4) }

    it "calculates median rating with shift" do
      expect(subject).to eq(2)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
