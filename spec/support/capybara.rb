# frozen_string_literal: true

require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1280, 800],
    inspector: ENV.fetch("INSPECTOR") { false },
    timeout: 10,
    process_timeout: 10,
    pending_connection_errors: false,
    browser_options: {
      "no-sandbox": nil,
      "disable-gpu": nil,
      "enable-features": "NetworkService,NetworkServiceInProcess",
    },
    url_blacklist: [],
  )
end

Capybara.server = :puma, { Threads: "5:5" }
Capybara.javascript_driver = :cuprite
Capybara.default_max_wait_time = 8
