defmodule Sidekick.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Sidekick.Worker.start_link(arg)
      # {Sidekick.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sidekick.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp log_banner do
    banner = ~s"""
    _____ _     _      _    _      _
    /  ___(_)   | |    | |  (_)    | |
    \ `--. _  __| | ___| | ___  ___| | __
     `--. \ |/ _` |/ _ \ |/ / |/ __| |/ /
    /\__/ / | (_| |  __/   <| | (__|   <
    \____/|_|\__,_|\___|_|\_\_|\___|_|\_\
    """

    Logger.info(banner)
  end
end
