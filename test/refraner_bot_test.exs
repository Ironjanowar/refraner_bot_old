defmodule RefranerBotTest do
  use ExUnit.Case
  doctest RefranerBot

  test "greets the world" do
    assert RefranerBot.hello() == :world
  end
end
