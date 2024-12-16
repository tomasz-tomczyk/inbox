ExUnit.start()

defmodule Inbox.TestHandler do
  @behaviour Inbox.Handler

  def process(message) do
    send(self(), {:message, message})
  end
end

defmodule Inbox.TestRouter do
  use Plug.Test

  def call(adapter, body, opts \\ []) do
    opts =
      Keyword.merge(opts,
        adapter: adapter,
        handler: Inbox.TestHandler
      )

    conn =
      conn(:post, "/", Jason.encode!(body))
      |> put_req_header("content-type", "application/json")
      |> Plug.Parsers.call(
        Plug.Parsers.init(parsers: [:urlencoded, {:json, json_decoder: Jason}])
      )

    _conn = Inbox.Router.call(conn, opts)
  end
end
