#!/usr/bin/env ruby
# encoding: utf-8

require_relative "reciever"

# create a class and override proccess_message method
class LoggerReciever < Reciever

  # here we do what we want to message
  def proccess_message delivery_info, properties, body
   puts " [x] #{body}"
  end

end

# create an object and start
logger_reciever = LoggerReciever.new("logger_queue", "facebook_exchange")
logger_reciever.start
