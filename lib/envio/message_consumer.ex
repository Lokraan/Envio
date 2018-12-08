defmodule Envio.MessageConsumer do
  require Logger

  use Nostrum.Consumer

  alias Nostrum.Api

  @prefix "%%"

  def start_link do
    IO.puts "Addd"

    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE}, {msg}, _ws_state) do
    Logger.debug msg.content
    IO.puts @prefix <> "ping"
    case msg.content do
      @prefix <> "ping" ->
        Api.create_message(msg.channel_id, "pyongyang!")

      @prefix <> "addpic" ->
        IO.inspect msg.attachments(), label: "images"
        Api.create_message(msg.channel_id, "message added!")

      _ ->
        :ignore
    end
  end

  def handle_event(_event), do: :noop
end
