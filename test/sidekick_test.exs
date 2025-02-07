defmodule SidekickTest do
  use ExUnit.Case
  doctest Sidekick

  test "greets the world" do
    assert Sidekick.hello() == :world
  end
end
