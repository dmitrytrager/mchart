# create users
# create charts, 5-10 for user
# create comments, 1-3 for chart
# create likes, for charts and comments

# check rest karma points
# check ratings

# create some karma votes

# check karma and rest karma points
# check ratings

# reset points
# check rest karma points

# time travel 1 day
# check ratings

# time travel 10 days
# check ratings

# time travel 30 days
# check ratings

# time travel 100 days
# check ratings

# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Karma, type: :integration do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }
  let(:created_at)  { Time.zone.now }

  let(:voter1) { create(:user) }
  let(:voter2) { create(:user) }
  let(:voter3) { create(:user) }
  let(:voter4) { create(:user) }
  let(:voter5) { create(:user) }
  let(:voter6) { create(:user) }
  let(:voter7) { create(:user) }
  let(:voter8) { create(:user) }
  let(:voter9) { create(:user) }

  let!(:chart_1_1) { create(:chart, created_at:, user:) }
  let!(:chart_1_2) { create(:chart, created_at:, user:) }
  let!(:chart_1_3) { create(:chart, created_at:, user:) }
  let!(:chart_1_4) { create(:chart, created_at:, user:) }
  let!(:chart_1_5) { create(:chart, created_at:, user:) }
  let!(:chart_1_6) { create(:chart, created_at:, user:) }
  let!(:chart_1_7) { create(:chart, created_at:, user:) }
  let!(:chart_1_8) { create(:chart, created_at:, user:) }
  let!(:chart_1_9) { create(:chart, created_at:, user:) }

  let!(:chart_2_1) { create(:chart, created_at:, user: other_user) }
  let!(:chart_2_2) { create(:chart, created_at:, user: other_user) }
  let!(:chart_2_3) { create(:chart, created_at:, user: other_user) }
  let!(:chart_2_4) { create(:chart, created_at:, user: other_user) }
  let!(:chart_2_5) { create(:chart, created_at:, user: other_user) }
  let!(:chart_2_6) { create(:chart, created_at:, user: other_user) }

  let(:charts_1) do
    [chart_1_1, chart_1_2, chart_1_3, chart_1_4, chart_1_5, chart_1_6, chart_1_7]
  end
  let(:charts_2) do
    [chart_2_1, chart_2_2, chart_2_3, chart_2_4, chart_2_5]
  end

  let!(:setup) do
    # before do
    # for every chart from user and other_user:
    #   - 0..5 comments
    #   - 0..10 likes
    #   - 0..15 likes for every comment
    charts_1.each do |chart|
      rand(0..5).times do
        comment = create(:comment, chart:, created_at:, user: other_user)
        create_list(:like, rand(0..15), voter: other_user, voteable: comment)
      end
      create_list(:like, rand(0..10), voter: other_user, voteable: chart)
    end
    charts_2.each do |chart|
      rand(0..5).times do
        comment = create(:comment, chart:, created_at:, user:)
        create_list(:like, rand(0..15), voter: user, voteable: comment)
      end
      create_list(:like, rand(0..10), voter: user, voteable: chart)
    end

    # 5 votes for other_user karma
    create(:karma_vote, voter_id: voter1.id, votee_id: other_user.id)
    create(:karma_vote, voter_id: voter2.id, votee_id: other_user.id)
    create(:karma_vote, voter_id: voter3.id, votee_id: other_user.id)
    create(:karma_vote, voter_id: voter4.id, votee_id: other_user.id)
    create(:karma_vote, voter_id: voter5.id, votee_id: other_user.id)
    # 4 votes for user karma
    create(:karma_vote, voter_id: voter6.id, votee_id: user.id)
    create(:karma_vote, voter_id: voter7.id, votee_id: user.id)
    create(:karma_vote, voter_id: voter8.id, votee_id: user.id)
    create(:karma_vote, voter_id: voter9.id, votee_id: user.id)

    KarmaResetPoints.new.call
  end

  # day 0 values
  let!(:karma_1)      { user.karma }
  let!(:karma_2)      { other_user.karma }
  let!(:karma_pt_1)   { user.reload.karma_points }
  let!(:karma_pt_2)   { other_user.reload.karma_points }
  let!(:med_rating_1) { user.median_rating }
  let!(:med_rating_2) { other_user.median_rating }

  before { Rails.logger = Logger.new($stdout) }

  it "calculates initial karma and rating" do
    Rails.logger.info("Karma1: #{karma_1}")
    expect(karma_1).to be_present
    Rails.logger.info("Karma2: #{karma_2}")
    expect(karma_2).to be_present
    Rails.logger.info("Rating1: #{med_rating_1}")
    expect(med_rating_1).to be_present
    Rails.logger.info("Rating2: #{med_rating_2}")
    expect(med_rating_2).to be_present
  end

  it "allow to vote for karma and likes" do
    Karma::Vote.new(other_user, voter1, 1).call
    Karma::Vote.new(other_user, voter2, 1).call
    Likes::Vote.new(other_user, chart_2_1).call

    expect(other_user.reload.karma).to eq(karma_2)
    expect(other_user.reload.karma_points).to eq(karma_pt_2 - 5)

    KarmaResetPoints.new.call

    expect(other_user.reload.karma).to eq(karma_2)
    expect(other_user.karma_points).to eq(karma_pt_2)
  end

  it "checks that ratings equal on zero day" do
    Rating::CalculateJob.new.perform

    expect(med_rating_1).to eq(user.reload.rating)
    expect(med_rating_2).to eq(other_user.reload.rating)
  end

  [1, 10, 30, 100].each do |period|
    it "calculates rating after #{period} days" do
      Timecop.travel(period.days.after) do
        Rating::CalculateJob.new.perform

        expect(user.median_rating).not_to eq(user.reload.rating)
        expect(other_user.median_rating).not_to eq(other_user.reload.rating)

        if period == 100
          expect(user.reload.rating).to be_zero
          expect(other_user.reload.rating).to be_zero
        end
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
