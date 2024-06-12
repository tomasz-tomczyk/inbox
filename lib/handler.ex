defmodule Inbox.Handler do
  @moduledoc """
  Behaviour for handling messages once they've been processed.
  """
  @callback process(message :: Inbox.Message.t()) :: any()
end
