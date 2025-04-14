defmodule PlasmaAgent.Host do
  @moduledoc false

  def os do
    case :os.type() do
      {:unix, :darwin} -> :macos
      {:unix, :linux} -> :linux
      {:win32, _} -> :windows
      other -> other
    end
  end

  def arch do
    arch_string = to_string(:erlang.system_info(:system_architecture))

    cond do
      String.contains?(arch_string, "aarch64") ->
        :arm64

      String.contains?(arch_string, "arm") ->
        :arm

      String.contains?(arch_string, "x86_64") ->
        :x86_64

      String.contains?(arch_string, "i686") ->
        :x86

      String.contains?(arch_string, "i386") ->
        :x86

      true ->
        # Fallback to first part of architecture string
        arch_string
        |> String.split("-")
        |> List.first()
        |> String.to_atom()
    end
  end
end
