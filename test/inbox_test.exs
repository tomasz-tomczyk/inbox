defmodule InboxTest do
  use ExUnit.Case
  doctest Inbox

  test "greets the world" do
    assert Inbox.hello() == :world
  end
end
