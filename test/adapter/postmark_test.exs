defmodule Inbox.Adapter.PostmarkTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest Inbox.Adapter.Postmark

  @opts Inbox.Router.init(
          adapter: Inbox.Adapter.Postmark,
          handler: Inbox.TestHandler
        )

  @json_body File.read!("test/fixtures/postmark.json")

  test "inbound" do
    conn =
      conn(:post, "/", @json_body)
      |> put_req_header("content-type", "application/json")

    conn =
      Plug.Parsers.call(
        conn,
        Plug.Parsers.init(parsers: [:urlencoded, {:json, json_decoder: Jason}])
      )

    _conn = Inbox.Router.call(conn, @opts)
    assert_received({:message, message})

    assert %Inbox.Message{
             id: "f76b0e42-d880-4437-a1bb-f8941c6a5e2b",
             to: [{"", "81864ca8870aacba34cf17b2024d8f3f@inbound.postmarkapp.com"}],
             from: "me@tomasztomczyk.com",
             subject: "Hello world!",
             html:
               "<html><head></head><body><div><div><div class=\"\">Testing inbound emails :)</div></div><div></div><br><div class=\"gmail_signature\"></div></div></body></html>\n",
             text: "Testing inbound emails :)\n"
           } = message
  end
end
