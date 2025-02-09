defmodule Sidekick.Podman do
  @moduledoc ~S"""
  This module provides an manage the Podman instance and interact with it.
  """

  use OctoFetch,
    latest_version: "5.3.2",
    github_repo: "containers/podman",
    download_versions: %{
      "5.3.2" => [
        {:darwin, :arm64, "e19ccbf4643c9cd8caef92908edb790805de5b09e307c7ba0a4e22086c05c96f"}
      ]
    }

  require Logger

  def download_name(_, :darwin, :arm64), do: "podman-remote-release-darwin_arm64.zip"
end
