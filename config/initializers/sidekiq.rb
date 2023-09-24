# frozen_string_literal: true

unless Rails.env.test?
  Sidekiq.configure_server do |config|
    config.redis = {
      network_timeout: 5,
      namespace: "mchart-sidekiq",
      host: Rails.application.secrets.redis[:host],
      port: Rails.application.secrets.redis[:port],
    }
  end

  Sidekiq.configure_client do |config|
    config.redis = {
      network_timeout: 5,
      namespace: "mchart-sidekiq",
      host: Rails.application.secrets.redis[:host],
      port: Rails.application.secrets.redis[:port],
    }
  end
end
