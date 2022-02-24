# frozen_string_literal: true

# NB: `req` is a Rack::Request object (basically an env hash with friendly accessor methods)

BAD_IPS = [].freeze

# Throttle 10 requests/ip/second
# NB: return value of block is key name for counter
#     falsy values bypass throttling
Rack::Attack.throttle("req/ip", limit: 10, period: 1, &:ip)

# Throttle attempts to a particular path. 2 POSTs to /login per second per IP
Rack::Attack.throttle "logins/ip", limit: 2, period: 1 do |req|
  req.post? && req.path == "/users/sign_in" && req.ip
end

# Throttle login attempts per email, 10/minute/email
# Normalize the email, using the same logic as your authentication process, to
# protect against rate limit bypasses.
Rack::Attack.throttle "logins/email", limit: 2, period: 60 do |req|
  req.post? && req.path == "/users/sign_in" && req.params["email"].to_s.downcase.gsub(/\s+/, "")
end

# blocklist bad IPs from accessing admin pages
Rack::Attack.blocklist "bad_ips from logging in" do |req|
  req.path =~ %r{^\/admin} && BAD_IPS.include?(req.ip)
end

# safelist a User-Agent
Rack::Attack.safelist "internal user agent" do |req|
  req.user_agent == "InternalUserAgent"
end

Rack::Attack.cache.store = Redis.new(
  host: Rails.application.credentials.redis[:host],
  port: Rails.application.credentials.redis[:port],
  network_timeout: 5,
)
