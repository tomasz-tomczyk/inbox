defmodule Inbox.Adapter.PostmarkTest do
  use ExUnit.Case, async: true
  doctest Inbox.Adapter.Postmark

  test "processes inbound emails" do
    body = Inbox.Test.postmark(%{"MessageID" => "test-12345"})

    Inbox.TestRouter.call(Inbox.Adapter.Postmark, body)

    assert_received({:message, message})

    assert %Inbox.Message{
             id: "test-12345",
             to: [{"", "test-12345@inbound.postmarkapp.com"}],
             from: {"John Doe", "john@doe.com"},
             subject: "Hello world!",
             text: "Testing inbound emails\n"
           } = message
  end

  test "includes the raw message if the option was provided" do
    body = Inbox.Test.postmark(%{"MessageID" => "test-12345"})

    Inbox.TestRouter.call(Inbox.Adapter.Postmark, body)

    assert_received({:message, message})

    assert %Inbox.Message{raw: nil} = message

    body = Inbox.Test.postmark(%{"MessageID" => "test-12345"})

    Inbox.TestRouter.call(Inbox.Adapter.Postmark, body, raw: true)

    assert_received({:message, message})

    assert %Inbox.Message{raw: raw_attrs} = message

    assert Map.keys(raw_attrs) == [
             "Attachments",
             "Bcc",
             "BccFull",
             "Cc",
             "CcFull",
             "Date",
             "From",
             "FromFull",
             "FromName",
             "Headers",
             "HtmlBody",
             "MailboxHash",
             "MessageID",
             "MessageStream",
             "OriginalRecipient",
             "ReplyTo",
             "StrippedTextReply",
             "Subject",
             "Tag",
             "TextBody",
             "To",
             "ToFull"
           ]
  end

  test "processes the attachments" do
    body = Inbox.Test.postmark(%{"MessageID" => "test-12345"})

    Inbox.TestRouter.call(Inbox.Adapter.Postmark, body)

    assert_received({:message, message})

    assert %Inbox.Message{attachments: [attachment]} = message

    assert %Inbox.Attachment{
             content_type: "image/png",
             filename: "image.png",
             content_length: 4
           } = attachment
  end
end
