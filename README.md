Exemplo de utilização do RabbitMQ.

## Como rodar?

Instale as dependencias

```
$ gem install bundler
$ bundle install
```

Em um terminal:
```

$ bundle exec ruby logger_reciever.rb
```

Em outro terminal:

```
$ bundle exec ruby save_to_disk_reciever.rb
```

Rode a coleta do facebook:
Gere um access token aqui https://developers.facebook.com/tools/explorer
Esses tokens tem uma vida útil curta, de poucas horas. Se você quiser rodar
depois de um tempo, provavelmente deve gerar outro.
```
FB_ACCESS_TOKEN=__YOUR_ACCESS_TOKEN_HERE__ bundle exec ruby facebook_sender.rb

```

You must see a message in logger_reciever terminal and in db.txt
