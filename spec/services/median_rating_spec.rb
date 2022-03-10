# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe MedianRating do
  subject { described_class.new(user.charts, user.comments).call }

  let!(:user) { create(:user) }

  let!(:chart1) { create(:chart, user: user) }
  let!(:chart2) { create(:chart, user: user) }
  let!(:chart3) { create(:chart, user: user) }
  let!(:chart4) { create(:chart, user: user) }
  let!(:chart5) { create(:chart, user: user) }

  let!(:comment1) { create(:comment, user: user, chart: chart1) }
  let!(:comment2) { create(:comment, user: user, chart: chart1) }
  let!(:comment3) { create(:comment, user: user, chart: chart1) }
  let!(:comment4) { create(:comment, user: user, chart: chart1) }
  let!(:comment5) { create(:comment, user: user, chart: chart1) }

  context "when charts and comments have some likes" do
    let!(:chart1_likes) { create_list(:like, 3, voter: user, voteable: chart1) }
    let!(:chart2_likes) { create_list(:like, 2, voter: user, voteable: chart2) }
    # create_list(:like, 2, voter: user, voteable: chart3)
    # create_list(:like, 2, voter: user, voteable: chart4)
    # create_list(:like, 2, voter: user, voteable: chart5)

    let!(:comment1_likes) { create_list(:like, 7, voter: user, voteable: comment1) }
    let!(:comment2_likes) { create_list(:like, 6, voter: user, voteable: comment2) }
    let!(:comment3_likes) { create_list(:like, 5, voter: user, voteable: comment3) }
    let!(:comment4_likes) { create_list(:like, 2, voter: user, voteable: comment4) }
    # create_list(:like, 2, voter: user, voteable: comment5)

    it "calculates median rating with shift" do
      expect(subject).to eq(2)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
