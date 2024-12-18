defmodule Inbox.MixProject do
  use Mix.Project
  @version "0.1.3"
  @repo_url "https://github.com/tomasz-tomczyk/inbox"

  def project do
    [
      app: :inbox,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,

      # Tests
      test_coverage: [tool: ExCoveralls],

      # Hex
      package: package(),
      description: "Plug-based inbound email handling.",
      deps: deps(),

      # Docs
      name: "Inbox",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.0"},
      {:jason, "~> 1.4"},
      {:timex, "~> 3.0"},
      {:tzdata, "~> 1.1"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Tomasz Tomczyk"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  defp docs do
    [
      main: "Inbox",
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        "LICENSE.md": [title: "License"]
      ],
      source_ref: "v#{@version}",
      source_url: @repo_url,
      formatters: ["html"],
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end
end
