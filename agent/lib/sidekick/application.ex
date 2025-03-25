defmodule Sidekick.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("Starting Sidekick")
    Logger.info("Version: #{Application.fetch_env!(:sidekick, :version)}")

    children = [
      # Starts a worker by calling: Sidekick.Worker.start_link(arg)
      # {Sidekick.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: Sidekick.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
