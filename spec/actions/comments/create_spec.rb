# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comments::Create do
  subject { described_class.new(creator, chart, comment) }

  let(:creator)      { create(:user) }
  let(:user)         { create(:user) }
  let(:chart)        { create(:chart, user:) }
  let(:comment)      { { text: "text" } }

  let(:created_comment) { creator.comments.last }

  it "creates new comment" do
    subject.call

    expect(created_comment).to be_present
    expect(created_comment.text).to eq("text")
    expect(created_comment.chart_id).to eq(chart.id)
  end

  context "when last comment persists" do
    let(:created_at)    { 1.minute.ago }
    let!(:last_comment) { create(:comment, user: creator, created_at:, chart:) }

    it "creates second comment" do
      subject.call

      expect(creator.comments.count).to eq(2)
    end

    context "when karma is not enough" do
      before do
        create :karma_vote, voter_id: user.id, votee_id: creator.id, vote: -1
      end

      it "does not create second comment" do
        subject.call

        expect(creator.comments.count).to eq(1)
      end

      context "when last comment was created earlier" do
        let(:created_at) { 5.minutes.ago }

        it "creates second comment" do
          subject.call

          expect(creator.comments.count).to eq(2)
        end
      end
    end
  end
end
