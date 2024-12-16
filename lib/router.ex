defmodule Inbox.Router do
  @moduledoc """
  A `Plug.Router`. Should be used in a host application.

  ## Usage

  ```elixir
    pipeline :api do
      plug :accepts, ["json"]
      forward("/inbox", Inbox.Router,
        adapter: Inbox.Adapter.Postmark,
        handler: MyApp.Processor
      )
    end
  ```

  ## Supported options

  * `:adapter` - the adapter module to use
  * `:handler` - the handler module to use
  * `:raw` - whether to include the raw message attributes in the `Inbox.Message` struct
  """

  import Plug.Conn
  @behaviour Plug

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, opts) do
    handler = Keyword.fetch!(opts, :handler)
    adapter = Keyword.fetch!(opts, :adapter)

    case adapter.call(conn, handler, opts) do
      {:ok, conn} ->
        conn |> send_resp(:ok, "ok") |> halt()

      {:error, conn} ->
        conn |> send_resp(500, "error") |> halt()
    end
  end
end
