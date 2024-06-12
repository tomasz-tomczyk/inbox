defmodule Inbox.Router do
  @moduledoc false

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/inbound" do
    conn |> send_resp(200, "inbound")
  end

  match _ do
    conn |> send_resp(404, "not_found")
  end
end
