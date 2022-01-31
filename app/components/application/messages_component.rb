# frozen_string_literal: true

class Application::MessagesComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
  end
end