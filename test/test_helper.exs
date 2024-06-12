ExUnit.start()

defmodule Inbox.TestHandler do
  @behaviour Inbox.Handler

  def process(message) do
    send(self(), {:message, message})
  end
end
