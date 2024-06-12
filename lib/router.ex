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
  """

  import Plug.Conn
  @behaviour Plug

  @impl true
  def init(opts) do
    handler = Keyword.fetch!(opts, :handler)
    adapter = Keyword.fetch!(opts, :adapter)

    {adapter, handler}
  end

  @impl true
  def call(conn, opts) do
    {adapter, handler} = opts

    case adapter.call(conn, handler) do
      {:ok, conn} ->
        conn |> send_resp(:ok, "ok") |> halt()

      {:error, conn} ->
        conn |> send_resp(500, "error") |> halt()
    end
  end
end
