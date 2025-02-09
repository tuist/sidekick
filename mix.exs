defmodule Sidekick.MixProject do
  use Mix.Project

  def project do
    [
      app: :sidekick,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sidekick.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.2", only: [:dev, :test], runtime: false},
      {:mimic, "~> 1.10", only: :test},
      {:octo_fetch, "~> 0.4.0"}
    ]
  end
end
