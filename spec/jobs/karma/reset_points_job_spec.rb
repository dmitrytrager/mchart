# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MessageChain
RSpec.describe Karma::ResetPointsJob, type: :job do
  it "calls KarmaResetPoints" do
    expect(KarmaResetPoints).to receive_message_chain(:new, :call)

    subject.perform
  end
end
# rubocop:enable RSpec/MessageChain
