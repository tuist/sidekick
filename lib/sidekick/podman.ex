defmodule Sidekick.Podman do
  @moduledoc ~S"""
  This module provides an manage the Podman instance and interact with it.
  """

  alias Sidekick.Host

  require Logger

  @version "5.4.0"

  @doc ~s"""
  It returns the Podman version this version of Sidekick is pinned to.
  """
  def version, do: @version

  @doc ~s"""
  Downloads Podman #{@version} and extracts it into a directory for local usage.
  The version of Podman is tied to a version of Sidekick for determinism reasons to ease debugging and reasoning
  about Sidekick.

  ## Parameters

    - `opts`:
      - `cache_dir`: The cache directory where Podman will be downloaded. When not present, it falls back to the application configuration `[:sidekick, :cache_dir]` or the `sidekick` directory inside the [XDG](https://specifications.freedesktop.org/basedir-spec/latest/) cache home directory.

  ## Returns

  It returns a string path to the Podman binary.

  ## Examples

  In the default XDG cache home directory:

        iex> Sidekick.Podman.download_if_absent()
        "~/.cache/sidekick/podman/versions/5.4.0/podman-5.4.0/usr/bin/podman"
  """
  def download_if_absent(opts \\ []) do
    binary_path = binary_path(opts)
    if File.exists?(binary_path), do: binary_path, else: download(opts)
  end

  @doc ~S"""
  It returns a `String` path to the Lume binary.
  """
  def binary_path(opts) do
    case Host.os() do
      :linux -> Path.join(bin_directory(opts), "podman-remote-static-linux_amd64")
      :macos -> Path.join(bin_directory(opts), "podman")
    end
  end

  defp download(opts \\ []) do
    temporary_directory = Temp.mkdir!()
    download_path = Path.join(temporary_directory, release_asset_name())
    download_url = download_url()

    Logger.debug("Downloading Podman from #{download_url} into #{download_path}")

    try do
      %{status: 200} = Req.get!(download_url, into: File.stream!(download_path))

      Logger.debug("Comparing the shasums of the downloaded #{release_asset_name()} against the remote shasum")

      local_shasum = calculate_sha256(download_path)
      remote_shasum = remote_shasum()

      if local_shasum != remote_shasum do
        raise "The shasum of the downloaded #{release_asset_name()}, #{local_shasum}, doesn't match the remote shasum, #{remote_shasum}"
      end

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

  defp bin_directory(opts) do
    case Host.os() do
      :linux ->
        Path.join(directory(opts), "bin")

      :macos ->
        Path.join(directory(opts), "podman-#{@version}/usr/bin")
    end
  end

  defp extract(compressed_file_path, opts) do
    Logger.debug("Extracting #{compressed_file_path} to #{directory(opts)}")

    if String.ends_with?(compressed_file_path, "zip") do
      {:ok, _} =
        :zip.extract(String.to_charlist(compressed_file_path), [
          {:cwd, String.to_charlist(directory(opts))}
        ])
    else
      :ok =
        :erl_tar.extract(String.to_charlist(compressed_file_path), [
          {:cwd, String.to_charlist(directory(opts))},
          :compressed,
          :silent
        ])
    end
  end

  defp calculate_sha256(file_path) do
    file_path
    |> File.stream!(2048, [])
    |> Enum.reduce(
      :crypto.hash_init(:sha256),
      fn chunk, acc -> :crypto.hash_update(acc, chunk) end
    )
    |> :crypto.hash_final()
    |> Base.encode16(case: :lower)
  end

  defp directory(opts) do
    Path.join(
      Keyword.get(opts, :cache_dir) || Application.get_env(:sidekick, :cache_dir) ||
        XDGBasedir.user_cache_dir("sidekick"),
      "podman/versions/#{@version}/"
    )
  end

  defp remote_shasum do
    shasums_content =
      "https://github.com/containers/podman/releases/download/v5.4.0/shasums"
      |> Req.get!()
      |> Map.get(:body)

    filename = release_asset_name()

    shasums_content
    |> String.split("\n")
    |> Enum.find_value(fn line ->
      case String.split(line, "  ") do
        [shasum, name] when name == filename -> shasum
        _ -> nil
      end
    end)
  end

  defp release_asset_name do
    arch =
      case Host.arch() do
        :x86_64 -> "amd64"
        :x86 -> "amd64"
        arch -> "#{arch}"
      end

    case {Host.os(), arch} do
      {:linux, arch} ->
        "podman-remote-static-linux_#{arch}.tar.gz"

      {:macos, arch} ->
        "podman-remote-release-darwin_#{arch}.zip"

      {_, _} ->
        raise "Sidekick doesn't support this OS/arch combination."
    end
  end

  defp download_url do
    "https://github.com/containers/podman/releases/download/v#{@version}/#{release_asset_name()}"
  end
end
