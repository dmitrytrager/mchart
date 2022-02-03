# frozen_string_literal: true

class Application::NavigationMainComponent < ViewComponent::Base
  delegate :user_signed_in?, to: :helpers
end
