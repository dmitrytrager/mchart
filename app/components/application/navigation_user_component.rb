# frozen_string_literal: true

class Application::NavigationUserComponent < ViewComponent::Base
  delegate :user_signed_in?, to: :helpers
end