defmodule PlasmaAgent.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("Starting Plasma Agent")
    Logger.info("Version: #{Application.fetch_env!(:plasma_agent, :version)}")

    children = [
      # Starts a worker by calling: Sidekick.Worker.start_link(arg)
      # {PlasmaAgent.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: PlasmaAgent.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
