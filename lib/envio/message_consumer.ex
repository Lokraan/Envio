defmodule Envio.MessageConsumer do
  require Logger

  use Nostrum.Consumer

  alias Nostrum.Api

  alias Envio.Store

  @prefix "%%"

  def start_link do
    Logger.debug "Starting #{__MODULE__}"

    Store.store().create_store()
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}) do
    Logger.debug "Handling :MESSAGE_CREATE event."
    case msg.content do
      @prefix <> "ping" ->
        Api.create_message(msg.channel_id, "pyongyang!")

      @prefix <> "piclist" ->
        pic_list = Enum.join(Store.store().image_list(), " ")
        Api.create_message(msg.channel_id, pic_list)

      _ ->
        if String.starts_with?(msg.content, @prefix <> "addpic"), do: add_pic(msg)

        if String.starts_with?(msg.content, @prefix <> "pic"), do: display_pic(msg)
      end
  end

  def handle_event(_event), do: :noop

  defp add_pic(msg) do
    msg_split = String.split(msg.content, @prefix <> "addpic ", trim: true)
    image = List.first(msg.attachments())
    fname = List.first(msg_split)

    Logger.debug image
    case Store.store().store_image(image, fname) do
      {:ok, _} ->
        Api.create_message(msg.channel_id, "image added!")
        Logger.info "Saved an image."

      {:error, reason} ->
        Api.create_message(msg.channel_id, reason)
    end
  end

  defp display_pic(msg) do
    msg_split = String.split(msg.content, @prefix <> "pic ", trim: true)
    
    if length(msg_split) == 0 do
      Api.create_message(msg.channel_id, "please reference an image to post")
    else
      img_name = List.first(msg_split)
      case Store.store().retrieve_image(img_name) do
        {:ok, img} ->
          Api.create_message(msg.channel_id, file: img)
          Logger.info "Sent an image"

        {:error, reason} ->
          Api.create_message(msg.channel_id, reason)
      end
    end
  end
end
