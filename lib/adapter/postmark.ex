defmodule Inbox.Adapter.Postmark do
  @moduledoc """
  The Postmark adapter for handling inbound messages.

  https://postmarkapp.com/
  """
  @behaviour Inbox.Adapter

  @impl Inbox.Adapter
  def call(%{params: params} = conn, handler) do
    message = %Inbox.Message{
      id: params["MessageID"],
      to: parse_to(params["ToFull"]),
      from: {params["FromFull"]["Name"], params["FromFull"]["Email"]},
      subject: params["Subject"],
      html: params["HtmlBody"],
      text: params["TextBody"],
      timestamp: Timex.parse!(params["Date"], "{RFC1123}"),
      raw: params
    }

    handler.process(message)

    {:ok, conn}
  end

  defp parse_to(to_full) do
    Enum.map(to_full, fn full -> {full["Name"], full["Email"]} end)
  end
end
