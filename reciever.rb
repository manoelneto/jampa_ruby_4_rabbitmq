require "bunny"

class Reciever

  def initialize queue_name, exchange_name
    @queue_name = queue_name
    @exchange_name = exchange_name
  end

  def start
    # then connect to RabbitMQ server
    # default is localhost
    @conn = Bunny.new
    @conn.start

    # Next we create a channel, which is where most of the API for getting things done resides:
    @conn.with_channel do |channel|

      # pedimos para criar a fila @queue_name automaticamente
      # de modo que não precisamos explicitamente cria-la no rabbitmq
      queue = channel.queue(@queue_name)

      # pedimos para que o exchange mande mensagens para a queue
      # de modo que não precisamos explicitamente fazer o 'bind' no rabbitmq
      queue.bind(@exchange_name)

      begin
        p "Listening to messages in #{queue.name}"
        queue.subscribe(:block => true) do |delivery_info, properties, body|
          self.proccess_message delivery_info, properties, body
        end
      rescue Interrupt => _
        @conn.close
        self.after_proccess
      end

    end
  end

  def proccess_message delivery_info, properties, body
    fail NotImplementedError, "A Reciever class must be able to #proccess_message!"
  end

  def after_proccess
    # we will do nothing
  end
end
