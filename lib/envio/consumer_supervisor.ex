defmodule Envio.ConsumerSupervisor do
  require Logger

  def start_link do
    children = [%{
      id: Envio.MessageConsumer,
      start: {Envio.MessageConsumer, :start_link, []}
    }]  
    
    Logger.debug "Starting #{__MODULE__}"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
