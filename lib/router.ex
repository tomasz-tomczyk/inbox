defmodule Inbox.Router do
  @moduledoc """
  A `Plug.Router`. Should be used in a host application.

  ## Usage

  ```elixir
    pipeline :api do
      plug :accepts, ["json"]
      forward "/inbox", Inbox.Router
    end
  ```
  """

  use Plug.Router
  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  get "/inbound" do
    conn |> send_resp(200, "inbound")
  end

  match _ do
    conn |> send_resp(404, "not_found")
  end
end
