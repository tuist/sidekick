defmodule Sidekick.Lume do
  @moduledoc ~S"""
  This module provides an manage the Luma instance and interact with it.
  """

  require Logger

  @version "0.1.8"

  def download do
    download_url = "https://github.com/trycua/lume/releases/download/v#{@version}/lume.pkg.tar.gz"
  end
end
