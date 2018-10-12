defmodule EveryTest do
  use ExUnit.Case
  doctest Every

  test "greets the world" do
    assert Every.hello() == :world
  end
end
