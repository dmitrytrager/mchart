# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MessageChain
RSpec.describe Karma::ResetJob, type: :job do
  let!(:user) { create(:user) }

  before do
    allow(KarmaReset).to receive_message_chain(:new, :call)
  end

  it "calls KarmaReset" do
    expect(KarmaReset).to receive_message_chain(:new, :call)

    subject.perform(user.id)
  end
end
# rubocop:enable RSpec/MessageChain
