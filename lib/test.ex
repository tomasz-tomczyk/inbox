defmodule Inbox.Test do
  @moduledoc """
  Stubs with default data to test the adapters.

  ## Usage

  ```elixir
  test "POST /inbox", %{conn: conn} do
    data = Inbox.Test.postmark()
    conn = post(conn, ~p"/inbox", data)
    assert response(conn, 200) =~ "ok"
  end
  ```
  """

  @doc """
  Stub for a Postmark inbound email.

  See the source code for the map with default values, which can be overriden
  with the `data` argument.
  """
  @spec postmark(map()) :: map()
  def postmark(data \\ %{}) do
    %{
      "FromName" => "John Doe",
      "MessageStream" => "inbound",
      "From" => "john@doe.com",
      "FromFull" => %{
        "Email" => "john@doe.com",
        "Name" => "John Doe",
        "MailboxHash" => ""
      },
      "To" => "test-12345@inbound.postmarkapp.com",
      "ToFull" => [
        %{
          "Email" => "test-12345@inbound.postmarkapp.com",
          "Name" => "",
          "MailboxHash" => ""
        }
      ],
      "Cc" => "",
      "CcFull" => [],
      "Bcc" => "",
      "BccFull" => [],
      "OriginalRecipient" => "test-12345@inbound.postmarkapp.com",
      "Subject" => "Hello world!",
      "MessageID" => "f76b0e42-d880-4437-a1bb-f8941c6a5e2b",
      "ReplyTo" => "",
      "MailboxHash" => "",
      "Date" => "Wed, 12 Jun 2024 04:43:56 -0400",
      "TextBody" => "Testing inbound emails\n",
      "HtmlBody" =>
        "<html><head></head><body><div><div><div class=\"\">Testing inbound emails</div></div><div></div><br><div class=\"gmail_signature\"></div></div></body></html>\n",
      "StrippedTextReply" => "",
      "Tag" => "",
      "Headers" => [
        %{"Name" => "Return-Path", "Value" => "<john@doe.com>"},
        %{
          "Name" => "Received",
          "Value" =>
            "by p-pm-inboundg02a-aws-euwest1a.inbound.postmarkapp.com (Postfix, from userid 996) tid B14D7453CA2; Wed, 12 Jun 2024 08:43:58 +0000 (UTC)"
        },
        %{
          "Name" => "X-Spam-Checker-Version",
          "Value" => "SpamAssassin 3.4.0 (2014-02-07) on t-p-m-inboundg02a-aws-euwest1a"
        },
        %{"Name" => "X-Spam-Status", "Value" => "No"},
        %{"Name" => "X-Spam-Score", "Value" => "-0.0"},
        %{
          "Name" => "X-Spam-Tests",
          "Value" =>
            "DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_NONE, T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY"
        },
        %{
          "Name" => "Received-SPF",
          "Value" =>
            "none (doe.com: No applicable sender policy available) receiver=p-pm-inboundg02a-aws-euwest1a; identity=mailfrom; envelope-from=\"john@doe.com\"; helo=mail-lj1-f180.google.com; client-ip=209.85.208.180"
        },
        %{
          "Name" => "Received",
          "Value" =>
            "from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by p-pm-inboundg02a-aws-euwest1a.inbound.postmarkapp.com (Postfix) with ESMTPS id 365FA453CA4 for <test-12345@inbound.postmarkapp.com>; Wed, 12 Jun 2024 08:43:58 +0000 (UTC)"
        },
        %{
          "Name" => "Received",
          "Value" =>
            "by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso70489061fa.0 for <test-12345@inbound.postmarkapp.com>; Wed, 12 Jun 2024 01:43:58 -0700 (PDT)"
        },
        %{
          "Name" => "X-Gm-Message-State",
          "Value" =>
            "AOJu0Yz/odaYL/D95HnxE8IgQ6T3CmSdu16nsYgNQlITJW5L9vLF1E46 u7FDUYqESvJ4oCAms8oGw+VK06c69qqfS/uoZJnHPDgfPVV8g/w037a9x/FLCwOhLpFBFPNpFYI GyVTH9mcIPWrxtPTCVdsi1BCew8lT+veObolJ+R9wb4swU7xc"
        },
        %{
          "Name" => "X-Google-Smtp-Source",
          "Value" =>
            "AGHT+IEimXlpkr2dvO8lHexxsAAf+L0wAmBL6ssIM6lQ8b9bDsyg6gMuAK/6bHnO6ILwcAK1wNQRuMjMELs5HI+pSns="
        },
        %{
          "Name" => "X-Received",
          "Value" =>
            "by 2002:a2e:9085:0:b0:2ea:eaa1:1bf3 with SMTP id 38308e7fff4ca-2ebfc8d6342mr6559801fa.21.1718181837048; Wed, 12 Jun 2024 01:43:57 -0700 (PDT)"
        },
        %{
          "Name" => "Received",
          "Value" =>
            "from 649336022844 named unknown by gmailapi.google.com with HTTPREST; Wed, 12 Jun 2024 04:43:56 -0400"
        },
        %{"Name" => "Mime-Version", "Value" => "1.0"},
        %{
          "Name" => "Message-ID",
          "Value" => "<CAC6GPT7PKGO0NRtjon3C0_sULPqEkSD=Pw7HwjBS=6iQ_S5EEA@mail.gmail.com>"
        }
      ],
      "Attachments" => [
        %{
          "ContentLength" => 4,
          "ContentType" => "image/png",
          "Name" => "image.png",
          "Content" => "dGVzdA=="
        }
      ]
    }
    |> Map.merge(data)
  end
end
