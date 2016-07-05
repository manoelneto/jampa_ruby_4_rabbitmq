#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# then connect to RabbitMQ server
conn = Bunny.new
conn.start

content = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

# Next we create a channel, which is where most of the API for getting things done resides:
conn.with_channel do |channel|

  # we need to create an exchange
  exchange = channel.fanout("jampa_ruby_4_ex", durable: true)

  # now we publish message
  exchange.publish(content)

end

# we need to close connection after use
conn.close
