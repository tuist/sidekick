defmodule PlasmaAgent.Lume do
  @moduledoc ~S"""
  This module provides and manage the Luma instance and interact with it.
  """

  alias PlasmaAgent.Host

  require Logger

  @version "0.1.9"

  @doc ~s"""
  It returns the Lume version this version of the agent is pinned to.
  """
  def version, do: @version

  @doc ~s"""
  Downloads Lume #{@version} and extracts it into a directory for local usage.
  The version of Lume is tied to a version of the Plasma Agent for determinism reasons to ease debugging and reasoning
  about the agent.

  ## Parameters

    - `opts`:
      - `cache_dir`: The cache directory where Lume will be downloaded. When not present, it falls back to the application configuration `[:plasma_agent, :cache_dir]` or the `plasma_agent` directory inside the [XDG](https://specifications.freedesktop.org/basedir-spec/latest/) cache home directory.

  ## Returns

  It returns a string path to the Lume binary.

  ## Examples

  In the default XDG cache home directory:

        iex> PlasmaAgent.Lume.download_if_absent()
        "~/.cache/plasma_agent/lume/versions/0.1.9/lume"
  """
  def download_if_absent(opts \\ []) do
    binary_path = binary_path(opts)
    if File.exists?(binary_path), do: binary_path, else: download(opts)
  end

  @doc ~S"""
  It returns a `String` path to the Lume binary.
  """
  def binary_path(opts) do
    Path.join(bin_directory(opts), "lume")
  end

  defp download(opts \\ []) do
    temporary_directory = Temp.mkdir!()
    download_path = Path.join(temporary_directory, release_asset_name())
    download_url = download_url()

    Logger.debug("Downloading Lume from #{download_url} into #{download_path}")

    try do
      %{status: 200} = Req.get!(download_url, into: File.stream!(download_path))

      extract(download_path, opts)
    after
      File.rm_rf!(temporary_directory)
    end

    make_binaries_executable(opts)

    binary_path(opts)
  end

  defp make_binaries_executable(opts) do
    Logger.debug("Making binaries at #{bin_directory(opts)} executable")

    for binary_path <- Path.wildcard(Path.join(bin_directory(opts), "*")) do
      File.chmod(binary_path, 755)
    end
  end

  defp make_binaries_executable(opts) do
    Logger.debug("Making binaries at #{bin_directory(opts)} executable")

    for binary_path <- Path.wildcard(Path.join(bin_directory(opts), "*")) do
      File.chmod(binary_path, 755)
    end
  end

  defp bin_directory(opts) do
    directory(opts)
  end

  defp extract(compressed_file_path, opts) do
    Logger.debug("Extracting #{compressed_file_path} to #{directory(opts)}")

    :ok =
      :erl_tar.extract(String.to_charlist(compressed_file_path), [
        {:cwd, String.to_charlist(directory(opts))},
        :compressed,
        :silent
      ])
  end

  defp directory(opts) do
    Path.join(
      Keyword.get(opts, :cache_dir) || Application.get_env(:plasma_agent, :cache_dir) ||
        XDGBasedir.user_cache_dir("plasma_agent"),
      "lume/versions/#{@version}/"
    )
  end

  defp release_asset_name do
    arch =
      case Host.arch() do
        :x86_64 -> "amd64"
        :x86 -> "amd64"
        arch -> "#{arch}"
      end

    case {Host.os(), arch} do
      {:macos, arch} ->
        "lume.tar.gz"

      {_, _} ->
        raise "Lume doesn't support this OS/arch combination."
    end
  end

  defp download_url do
    "https://github.com/trycua/lume/releases/download/v#{@version}/#{release_asset_name()}"
  end
end
