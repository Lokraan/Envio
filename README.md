# Envio
Envio is a discord bot that handles file uploads and posts built on top of the [Nostrum Discord API](https://github.com/Kraigie/nostrum).


## Adding Envio to your server.
I currently host the bot part time and am looking to host it permanently sometime soon.
[Invite Bot](https://discordapp.com/oauth2/authorize?client_id=520799790485864458&scope=bot&permissions=314432)


## Self Hosting
1) run `git clone https::github.com/lokraan/envio.git`
2) run `cd envio`
3) rename `config/config.secret.exs.example` to `config/config.secret.exs` and edit `token: example` to include your bot's token.
4) run `mix do deps.get, deps.compile`
5) run `iex -S mix app.start`


## Commands
| Command  | Description|
| ---------------- | ----------------------- |
| `%%ping`         | Responds with pyonyang. | 
| `%%addpic <name>`| Saves the first image sent in the message as it's default filename or the name specified by the user. | 
| `%%pic <name>`   | Retrieves the image with the name specified. Informs a user if the image doesn't exist. |
| `%%piclist`      | Sends a list of all images saved. |


## Installation
```elixir
def deps do
  [
    {:envio, "~> 0.1.0", git: "https://github.com/lokraan/envio.git"}}
  ]
end
```
