defmodule PlasmaAgent.PodmanTest do
  use ExUnit.Case

  alias PlasmaAgent.Podman

  @tag :tmp_dir
  test "downloads podman successfully", %{tmp_dir: tmp_dir} do
    # When
    executable_path = Podman.download_if_absent(cache_dir: tmp_dir)

    # Then
    assert File.exists?(executable_path)
    {stdout, 0} = System.cmd(executable_path, ["--version"])
    assert String.contains?(stdout, Podman.version())
  end
end
