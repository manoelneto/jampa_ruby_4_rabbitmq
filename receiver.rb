#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# then connect to RabbitMQ server
conn = Bunny.new
conn.start

# Next we create a channel, which is where most of the API for getting things done resides:
conn.with_channel do |channel|

  # we need to create an exchange
  queue = channel.queue("jampa_ruby_4_queue")

  # pedimos para que o exchange mande mensagens para a queue
  queue.bind("jampa_ruby_4_ex")

  begin
    p "Listening to messages in #{queue.name}"
    queue.subscribe(:block => true) do |delivery_info, properties, body|
      puts " [x] #{body}"
    end
  rescue Interrupt => _
    conn.close
  end

end

