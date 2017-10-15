defmodule EslixirTest do
  use ExUnit.Case
  doctest Eslixir

  test "greets the world" do
    assert Eslixir.hello() == :world
  end
end
