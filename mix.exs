defmodule Every.MixProject do
  use Mix.Project
  @vsn "0.0.9"

  @deps [
    {:timex, "~> 3.6"},
    {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    {:excoveralls, "~> 0.12", only: :test},
    {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
    {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
  ]

  @package [
    name: "every",
    files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
    licenses: ["Apache 2.0"],
    links: %{"GitHub" => "https://github.com/imanhodjaev/every"}
  ]

  @description "Calculate even intervals for `Process.send_after/3`"

  def project do
    [
      app: :every,
      version: @vsn,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      description: @description,
      package: @package,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :timex]
    ]
  end
end
