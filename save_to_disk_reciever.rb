#!/usr/bin/env ruby
# encoding: utf-8

require_relative "reciever"

class SaveToDiskReciever < Reciever

  def proccess_message delivery_info, properties, body
    # just append message to file
    # warning: this method isn`t the best to write a file, since for
    # all message we`re opening the file, inserting and close.

    @file = File.open(File.join(File.dirname(__FILE__), "db.txt"), "a")
    @file.puts body
    @file.close

  end

end


logger_reciever = SaveToDiskReciever.new("disk_queue", "facebook_exchange")
logger_reciever.start
