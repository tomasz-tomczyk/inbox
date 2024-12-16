defmodule Inbox.Message do
  @moduledoc """
  Struct for incoming messages.
  """

  @type t :: %__MODULE__{
          id: String.t(),
          to: [{String.t(), String.t()}] | nil,
          from: [{String.t(), String.t()}],
          subject: String.t() | nil,
          html: String.t() | nil,
          text: String.t() | nil,
          timestamp: DateTime.t() | nil,
          attachments: [Inbox.Attachment.t()] | nil,
          raw: map()
        }
  @enforce_keys [:id, :to]
  defstruct [
    :id,
    :to,
    :from,
    :subject,
    :html,
    :text,
    :timestamp,
    :attachments,
    :raw
  ]
end
