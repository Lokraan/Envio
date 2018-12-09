defmodule Envio do
  require Logger

  use Application

  def start(_type, _args) do
    children = [%{
      id: Envio.ConsumerSupervisor,
      start: {Envio.ConsumerSupervisor, :start_link, []}
    }]

    Logger.debug "Starting #{__MODULE__}"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
