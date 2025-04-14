defmodule PlasmaAgent.MixProject do
  use Mix.Project

  def project do
    [
      app: :plasma_agent,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PlasmaAgent.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.2", only: [:dev, :test], runtime: false},
      {:mimic, "~> 1.10", only: :test},
      {:temp, "~> 0.4"},
      {:burrito, "~> 1.0"},
      {:req, "~> 0.5.5"},
      {:xdg_basedir, "~> 0.1.1"}
    ]
  end

  def releases do
    [
      plasma_agent: [
        steps: [:assemble, &Burrito.wrap/1],
        burrito: [
          targets: [
            macos: [os: :darwin, cpu: :aarch64],
            linux: [os: :linux, cpu: :x86_64]
          ]
        ]
      ]
    ]
  end
end
