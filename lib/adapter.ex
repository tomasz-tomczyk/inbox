defmodule Inbox.Adapter do
  @moduledoc """
  The adapter behaviour for creating inbound message plugins.
  """
  @callback call(conn :: Plug.Conn.t(), handler :: atom()) ::
              {:ok, conn :: Plug.Conn.t()} | {:error, conn :: Plug.Conn.t(), String.t()}
end
