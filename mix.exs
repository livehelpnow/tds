defmodule Tds.Mixfile do
  use Mix.Project

  @source_url "https://github.com/livehelpnow/tds"
  @version "2.1.3"

  def project do
    [
      app: :tds,
      version: @version,
      elixir: "~> 1.0",
      name: "Tds",
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      xref: [exclude: [:ssl]],
      rustler_crates: [
        tds_encoding: [
          mode: if(Mix.env() == :prod, do: :release, else: :debug)
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :db_connection, :decimal],
      env: [
        json_library: Jason
      ]
    ]
  end

  defp deps do
    [
      {:binpp, ">= 0.0.0", only: [:dev, :test]},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:db_connection, "~> 2.0"},
      {:decimal, "~> 1.6"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.7", only: :test},
      {:jason, "~> 1.0", optional: true},
      {:tds_encoding, "~> 1.0", optional: true, only: :test},
      {:tzdata, "~> 1.0", optional: true, only: :test}
    ]
  end

  defp package do
    [
      name: "tds",
      description:
        "Microsoft SQL Server client (Elixir implementation of the MS TDS protocol)",
      files: ["lib", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"],
      maintainers: ["Eric Witchin", "Milan Jaric"],
      licenses: ["Apache-2.0"],
      links: %{"Github" => "https://github.com/livehelpnow/tds"}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
