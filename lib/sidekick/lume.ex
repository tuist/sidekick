defmodule Sidekick.Lume do
  @moduledoc ~S"""
  This module provides an manage the Luma instance and interact with it.
  """

  use OctoFetch,
    latest_version: "0.1.7",
    github_repo: "trycua/lume",
    download_versions: %{
      "0.1.7" => [
        {:darwin, :arm64, "00ea9badf7d42da0a88af7d572e3ab9529a4104c2fed2d3ce352a10141ea9249"},
        {:darwin, :amd64, "00ea9badf7d42da0a88af7d572e3ab9529a4104c2fed2d3ce352a10141ea9249"}
      ]
    }

  require Logger

  def download do
    OctoFetch.download()
  end

  def download_name(version, _, _), do: "lume.tar.gz"
end
