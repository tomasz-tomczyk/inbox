ExUnit.start()

defmodule Inbox.TestHandler do
  @behaviour Inbox.Handler

  def process(message) do
    send(self(), {:message, message})
  end
end

defmodule Inbox.TestRouter do
  use Plug.Test

  def call(adapter, json_body) do
    opts =
      Inbox.Router.init(
        adapter: adapter,
        handler: Inbox.TestHandler
      )

    conn =
      conn(:post, "/", json_body)
      |> put_req_header("content-type", "application/json")
      |> Plug.Parsers.call(
        Plug.Parsers.init(parsers: [:urlencoded, {:json, json_decoder: Jason}])
      )

    _conn = Inbox.Router.call(conn, opts)
  end
end
