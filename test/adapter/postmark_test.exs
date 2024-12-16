defmodule Inbox.Adapter.PostmarkTest do
  use ExUnit.Case, async: true
  doctest Inbox.Adapter.Postmark

  test "processes inbound emails" do
    body = Inbox.Test.postmark(%{"MessageID" => "test-12345"})

    Inbox.TestRouter.call(Inbox.Adapter.Postmark, body)

    assert_received({:message, message})

    assert %Inbox.Message{
             id: "test-12345",
             to: [{"", "test-12345@inbound.postmarkapp.com"}],
             from: {"John Doe", "john@doe.com"},
             subject: "Hello world!",
             text: "Testing inbound emails\n"
           } = message
  end
end
