defmodule Inbox.Attachment do
  @moduledoc """
  Struct for incoming attachments.
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          filename: String.t(),
          content_type: String.t(),
          content_length: number(),
          data: binary | nil
        }
  defstruct [
    :id,
    :filename,
    :content_type,
    :content_length,
    :data
  ]
end
