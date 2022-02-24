# frozen_string_literal: true

require "irb"

env = Rails.env
env_color = if env.production?
  "\e[31m#{env}\e[0m"
else
  env
end

IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:RAILS_APP] = {
  PROMPT_I: "MChart (#{env_color}) > ",
  PROMPT_N: nil,
  PROMPT_S: nil,
  PROMPT_C: nil,
  RETURN: "=> %s\n",
}

IRB.conf[:PROMPT_MODE] = :RAILS_APP
