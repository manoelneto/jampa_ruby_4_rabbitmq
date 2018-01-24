#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require "httparty"

# Custom errors to make developers debug easier
class AccessTokenMissingException < Exception ; end
class FacebookRequestException < Exception ; end

FB_ACCESS_TOKEN = ENV['FB_ACCESS_TOKEN']

# raise an error if there`s not access token
if FB_ACCESS_TOKEN.nil? or FB_ACCESS_TOKEN == ''
  raise AccessTokenMissingException.new("Access token is missing, you must run this code and pass an access token.")
end

# make a request and get user info from facebook
resp = HTTParty.get("https://graph.facebook.com/v2.11/me?access_token=#{FB_ACCESS_TOKEN}")

if not resp.success?
  FacebookRequestException.new("There was an error on requesting to facebook #{resp.body}")
end


# then connect to RabbitMQ server
conn = Bunny.new
conn.start

# Next we create a channel, which is where most of the API for getting things done resides:
conn.with_channel do |channel|

  # we need to create an exchange
  exchange = channel.fanout("facebook_exchange", durable: true)

  # now we publish message
  exchange.publish(resp.body)

end

# we need to close connection after use
conn.close

p "successfully published users info"
