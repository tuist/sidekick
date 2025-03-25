defmodule Sidekick.LumeTest do
  use ExUnit.Case

  alias Sidekick.Lume

  @tag :tmp_dir
  test "downloads lume successfully", %{tmp_dir: tmp_dir} do
    # Lume is a macOS tool.
    if Sidekick.Host == :macos do
      # When
      executable_path = Lume.download_if_absent(cache_dir: tmp_dir)

      # Then
      assert File.exists?(executable_path)
      {stdout, 0} = System.cmd(executable_path, ["--version"])
      assert String.contains?(stdout, Lume.version())
    end
  end
end
