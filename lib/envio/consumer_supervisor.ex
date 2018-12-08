defmodule Evio.ConsumerSupervisor do
  require Logger

  def start_link do
    children = [Envio.MessageConsumer]  
    Logger.debug "??/"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
