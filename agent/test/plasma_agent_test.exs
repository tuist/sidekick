defmodule PlasmaAgentTest do
  use ExUnit.Case

  doctest PlasmaAgent

  test "greets the world" do
    assert PlasmaAgent.hello() == :world
  end
end
